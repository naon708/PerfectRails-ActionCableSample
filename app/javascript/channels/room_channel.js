import consumer from "./consumer"

consumer.subscriptions.create("RoomChannel", {
  // 接続時
  connected() {
    // Called when the subscription is ready for use on the server
  },

  // 切断時
  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  // サーバーからデータを受信した時
  received(data) {
    // Called when there's incoming data on the websocket for this channel
  },

  speak: function() {
    // サーバーサイドのspeakメソッドをWebSocket経由で呼び出す
    return this.perform('speak');
  }
});
