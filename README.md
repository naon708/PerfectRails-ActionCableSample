# Action Cable

[https://railsguides.jp/action_cable_overview.html](https://railsguides.jp/action_cable_overview.html)

## 用語

- WebSocket
    - プロトコル(通信の規格)
    - クライアント/サーバー間のコネクションを維持し、双方向でデータをやり取りするための通信規格
- コネクション
    - WebSocket接続を表すオブジェクトのこと
- コンシューマー
    - WebSocketコネクションにおけるクライアントのこと
    - Action Cableのコンシューマーは、クライアント側のJavaScriptフレームワークによって作成される
- チャネル / チャンネル
    - WebSocket処理におけるコントローラーのような役割を果たす
- サブスクライブ(購読)
    - あるイベントやチャネルに対してクライアントが関連付けされること
    - サブスクライブすることで、そのイベントやチャンネルに関する情報を受け取ることができる
    - 複数のチャネルを購読可能
- ブロードキャスト
    - 接続している全購読者への送信

```bash
コンシューマー(クライアント側)がActionCable(サーバー側)にWebSocket接続を開始するリクエストを投げる
↓
そのリクエストを受け取ったActionCableでコネクションオブジェクトを生成し、接続を確立
```

## Action Cable用のファイルを生成

```bash
create  app/channels/room_channel.rb 　　　　　　　# WebSocket処理のバックエンドを受け持つファイル
create  app/javascript/channels/room_channel.js 　# WebSocket処理のフロントエンドを受け持つファイル
....
```

## WebSocket通信開始時に/cableにアクセスするようになる

```bash
Started GET "/rooms/show"
....

Started GET "/cable"
Started GET "/cable/" [WebSocket]
Successfully upgraded to WebSocket (REQUEST_METHOD: GET, HTTP_CONNECTION: Upgrade, HTTP_UPGRADE: websocket)
RoomChannel is transmitting the subscription confirmation
```

## FEからBEにメッセージを送りそれをBroadcastしたものをFEが受け取りalert表示させた

```bash
# ログ
RoomChannel is streaming from room_channel
RoomChannel#speak({"message"=>"Hi!"})
[ActionCable] Broadcasting to room_channel: {:message=>"Hi!"}
RoomChannel transmitting {"message"=>"Hi!"} (via streamed from room_channel)
```

## チャット完成(リアルタイムで更新が反映された)

```bash
# ログ
RoomChannel#speak({"message"=>"OK!"})

 begin transaction
	  Message Create  INSERT INTO "messages" ("content", "created_at", "updated_at") VALUES (?, ?, ?)  [["content", "OK!"], ["created_at", "2023-04-06 14:09:44.839306"], ["updated_at", "2023-04-06 14:09:44.839306"]]
	  ↳ app/channels/room_channel.rb:15:in `speak'
 commit transaction

Rendered messages/_message.html.erb

[ActionCable] Broadcasting to room_channel: {:message=>"<div class=\"message\">\n  <p>OK!</p>\n</div>\n"}

RoomChannel transmitting {"message"=>"<div class=\"message\">\n  <p>OK!</p>\n</div>\n"} (via streamed from room_channel)
```

## 本番環境の運用

- アダプターはredisなどを使う
- Web用とWebSocket用でサーバーは分けたほうがよい

## ユニットテスト

[https://railsguides.jp/testing.html#action-cableをテストする](https://railsguides.jp/testing.html#action-cable%E3%82%92%E3%83%86%E3%82%B9%E3%83%88%E3%81%99%E3%82%8B)

- チャネル
    - [https://api.rubyonrails.org/classes/ActionCable/Channel/TestCase.html](https://api.rubyonrails.org/classes/ActionCable/Channel/TestCase.html)
- コネクション
    - [https://api.rubyonrails.org/classes/ActionCable/Connection/TestCase.html](https://api.rubyonrails.org/classes/ActionCable/Connection/TestCase.html)
