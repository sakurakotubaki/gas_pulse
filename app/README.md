# Gas Pulse app

バックエンドが配信する天然ガス価格をWebSocketで購読し、1分ごとの変化を折れ線グラフで表示するFlutterアプリです。

## 技術構成

- Flutter 3.44.4 / Dart 3.12
- Riverpod Generator
- Freezed / json_serializable
- web_socket_channel
- fl_chart

価格モデルと画面状態はFreezedでimmutableに定義しています。接続状態は`MarketConnectionStatus` enum、バックエンドの価格方向は`PriceStatus` enumで表現しています。

## 起動

VS Codeの「実行とデバッグ」から次の構成を選択できます。

- `Gas Pulse: dev`: Debugモード。ローカルの`ws://*:8080/ws/price`へ接続
- `Gas Pulse: prd`: Releaseモード。本番ホストを入力し、`wss://*:443/ws/price`へ接続

`prd`で入力する値は`api.example.com`のようなホスト名だけにしてください。プロトコルや`/ws/price`は自動設定されます。

コマンドラインで起動する場合は、ターミナル1でバックエンドを起動します。

```sh
cd ..
task backend:dev
```

ターミナル2でアプリを起動します。

```sh
mise exec -- flutter run
```

バックエンドの既定接続先:

- Android Emulator: `ws://10.0.2.2:8080/ws/price`
- iOS Simulator / Web / Desktop: `ws://localhost:8080/ws/price`

実機などで接続先を変える場合:

```sh
mise exec -- flutter run --dart-define=BACKEND_HOST=192.168.1.10
```

## コード生成

```sh
mise exec -- dart run build_runner build
```

## 検証

```sh
mise exec -- flutter analyze
mise exec -- flutter test
```

価格更新タイマーはFlutter側にはありません。接続直後の現在値と、その後のバックエンドバッチのイベントをそのまま描画します。切断した場合のみ、最大15秒間隔の指数バックオフでWebSocketへ再接続します。
