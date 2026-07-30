# Gas Pulse backend

Echo/Go製の天然ガス・仮想東証株価シミュレーションAPIです。サーバー内のバッチが価格を1分ごとに更新し、接続中のFlutterクライアントへWebSocketで配信します。

## 技術構成

- Go 1.24
- Echo v4（HTTPサーバー、ルーティング、ミドルウェア）
- Gorilla WebSocket（リアルタイム配信）
- Goroutine + `time.Ticker`（1分ごとの価格更新バッチ）
- インメモリストア（現在値と直近120件の履歴）

外部の価格データやDBには接続しません。プロセスを再起動すると履歴はリセットされます。

## 起動

リポジトリのルートで次を実行します。

```sh
task backend:run
```

標準では `http://localhost:8080` で起動し、価格は1分ごとに更新されます。

動作確認時に1分待たず、2秒ごとに更新するには次を使います。

```sh
task backend:dev
```

直接起動する場合:

```sh
cd backend
go mod download
PRICE_UPDATE_INTERVAL=2s go run .
```

設定できる環境変数:

| 変数 | 既定値 | 用途 |
| --- | --- | --- |
| `PORT` | `8080` | HTTP待受ポート |
| `PRICE_UPDATE_INTERVAL` | `1m` | バッチ更新間隔（例: `2s`） |
| `INITIAL_PRICE` | `2.853` | 起動時の価格 |

## API

| メソッド | パス | 内容 |
| --- | --- | --- |
| `GET` | `/health` | ヘルスチェック |
| `GET` | `/api/price` | 現在価格 |
| `GET` | `/api/history` | 起動後の価格履歴（最大120件） |
| `GET` | `/ws/price` | 現在価格と以後の更新をWebSocket配信 |
| `GET` | `/api/stocks` | 仮想東証6銘柄の現在スナップショット |
| `GET` | `/ws/stocks` | 仮想株価スナップショットをWebSocket配信 |

配信JSON:

```json
{
  "symbol": "NGAS/USD",
  "price": 2.853,
  "timestamp": 1718293847123,
  "status": "UP"
}
```

`timestamp` はUnix time（ミリ秒）、`status` は `UP`、`DOWN`、`EQUAL` のいずれかです。WebSocket接続直後には待ち時間なしで現在値が1件届きます。

株価APIも接続直後に現在値を返し、その後は同じバッチ間隔で6銘柄をまとめて配信します。`TSE-DEMO`は実在価格ではなくデモ用の仮想市場です。

## ローカル検証

ターミナル1:

```sh
task backend:dev
```

ターミナル2:

```sh
task backend:health
task backend:price
task backend:ws
```

`backend:ws` は `websocat` がインストール済みならそれを使い、なければGo製の検証クライアントを実行します。停止は `Ctrl+C` です。

テストと静的解析:

```sh
task backend:check
```

## Flutterから接続

`riverpod_generator` で `StreamProvider` を生成する例です。最初に依存関係を追加します。

```sh
flutter pub add flutter_riverpod riverpod_annotation web_socket_channel
flutter pub add --dev build_runner riverpod_generator
```

`lib/providers/gas_price_provider.dart`:

```dart
import 'dart:convert';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

part 'gas_price_provider.g.dart';

@riverpod
Stream<Map<String, dynamic>> gasPrice(Ref ref) {
  final channel = WebSocketChannel.connect(
    Uri.parse('ws://localhost:8080/ws/price'),
  );
  ref.onDispose(() => channel.sink.close());

  return channel.stream.map(
    (event) => jsonDecode(event as String) as Map<String, dynamic>,
  );
}
```

コードを生成します。

```sh
dart run build_runner build --delete-conflicting-outputs
```

Widgetでは、生成された `gasPriceProvider` を監視します。

```dart
final gasPrice = ref.watch(gasPriceProvider);

return switch (gasPrice) {
  AsyncData(:final value) => Text('\$${value['price']}'),
  AsyncError(:final error) => Text('接続エラー: $error'),
  _ => const CircularProgressIndicator(),
};
```

`AsyncData` では受信した価格を表示し、`AsyncError` では接続エラーを表示します。それ以外の初期接続中の状態はローディング表示として扱います。

Android EmulatorではホストPCの `localhost` は `10.0.2.2` なので、`ws://10.0.2.2:8080/ws/price` を使います。iOS Simulatorは通常 `localhost` で接続できます。実機ではPCのLAN内IPアドレスを指定してください。

1分間隔の処理はサーバー側のバッチです。Flutter側で1分タイマーを動かす必要はなく、生成された `StreamProvider` は届いたイベントに応じてUIを再描画するだけで構いません。
