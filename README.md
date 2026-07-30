# 📄 仕様書：天然ガス リアルタイム取引デモアプリ（1ページ完結型）

## 1. 概要

天然ガス（NGAS/USD）の価格変動をリアルタイムに表示するデモアプリ。バックエンドはWebSocketを用いて1分ごとの価格更新をFlutterへ配信する。

バックエンドの起動・検証方法は [`backend/README.md`](backend/README.md) を参照。

## 2. 技術スタック

- **フロントエンド**: Flutter / Dart
  - 状態管理: `flutter_riverpod`
  - WebSocket通信: `web_socket_channel`
  - チャート描画: `fl_chart` (または `candlesticks`)
- **バックエンド**: Go 1.24
  - Webフレームワーク: `labstack/echo/v4`
  - WebSocket: `gorilla/websocket`
  - バッチ処理: Goroutine + `time.Ticker`

## 3. 画面レイアウト（UI仕様）

1画面内に以下の4つのコンポーネントを配置する。

### ① ヘッダーエリア（現在価格と銘柄）

- **銘柄表示**: `NGAS/USD` (天然ガス)
- **現在価格**: 大きなフォントで表示（例: `$ 2.853`）。
  - ティック（Tick）更新時に、前回の価格より上がれば**緑色**、下がれば**赤色**に0.2秒間フラッシュするエフェクト。

### ② リアルタイムチャートエリア

- 現在価格から過去1分〜数分間の価格推移を折れ線（またはローソク足）チャートで表示。
- 右端に最新価格がプロットされ、時間が経つにつれて左へ自動スクロールする。

### ③ 取引パネル（発注エリア）

- **BUY（買）ボタン**: 画面左下。青または緑の巨大ボタン。
- **SELL（売）ボタン**: 画面右下。赤の巨大ボタン。
- タップすると即座にクライアント側で「建玉（ポジション）」を保持し、画面上にエフェクト（Hapticバイブレーション＋音）を発生させる。

### ④ ポジション＆損益エリア

- 現在保有している建玉（例: `BUY @ 2.850`）を表示。
- **リアルタイム評価損益**: 最新のWebSocket価格を受信するたびに損益（PnL）を再計算し、激しく上下する数値を表示。
- **全決済（CLOSE ALL）ボタン**: タップで現在のポジションをすべて決済し、口座残高に損益を反映させる。

## 4. バックエンド仕様 (Echo/Go)

### 4.1. エンドポイント


|              |                |                                       |
| ------------ | -------------- | ------------------------------------- |
| **HTTPメソッド** | **エンドポイント**    | **役割**                                |
| `GET`        | `/ws/price`    | クライアントとのWebSocket接続を確立し、価格をストリーム配信する。 |
| `GET`        | `/api/price`   | 現在の価格を返す。 |
| `GET`        | `/api/history` | 起動後の価格履歴（最大120件）を返す。 |
| `GET`        | `/health`      | サーバーの稼働状態を返す。 |


### 4.2. 天然ガス価格生成エンジン (Goroutine)

天然ガスの「ボラティリティの高さ（急激なスパイクや下落）」を再現する擬似価格ジェネレーター。

- **基準価格**: $2.500 〜 $3.500 の範囲。
- **配信頻度**: 1分に1回。接続直後のみ待ち時間なしで現在値を1件配信する。
- **価格変動ロジック**: 通常は小さなランダムウォークを行い、一定確率で大きめの変動を発生させる。

### 4.3. バッチ処理（Goroutineによる価格更新）

Echoサーバーの起動と同時にGoroutineでバッチ処理を稼働させる。

- **トリガー**: `time.Ticker` による1分間隔
- **処理内容**: 擬似価格を更新し、WebSocket購読者へ配信する。現在値と直近120件をメモリに保持する。

## 5. 通信データ仕様 (JSON)

### 5.1. WebSocket 配信データ (サーバー → クライアント)

JSON

```
{
  "symbol": "NGAS/USD",
  "price": 2.853,
  "timestamp": 1718293847123,
  "status": "UP" // UP, DOWN, EQUAL (フラッシュUI用)
}

```

### 5.2. クライアント側の状態管理（Flutter Riverpod想定）

※デモのレスポンス（リアルタイム性）を最優先するため、注文処理と損益計算はFlutter側の状態（メモリ）で処理する。

Dart

```
class Position {
  final String type; // "BUY" or "SELL"
  final double entryPrice; // 建値 (例: 2.850)
  final DateTime entryTime;
  double currentPnL; // 評価損益（WebSocket受信ごとに再計算）
}

```

## 6. ディレクトリ構成案

### バックエンド (Go / Echo)

Plaintext

```
backend/
 ├── main.go                    # Echoサーバーとバッチの起動
 ├── cmd/wscheck/main.go        # WebSocket動作確認クライアント
 └── internal/
      ├── httpapi/handler.go    # HTTP/WebSocketハンドラー
      └── price/service.go      # 価格生成、履歴、購読管理

```

### フロントエンド (Flutter)

Plaintext

```
lib/
 ├── main.dart             # エントリーポイント
 ├── providers/
 │    ├── ws_provider.dart # WebSocket通信の管理 (StreamProvider)
 │    └── trade_provider.dart # ポジション管理・損益計算 (StateNotifier)
 └── ui/
      ├── dashboard.dart   # メインの1ページUI
      ├── header.dart      # 価格のフラッシュ表示部品
      ├── chart.dart       # リアルタイムチャート描画部品
      └── action_panel.dart# BUY/SELL/決済ボタン群

```
