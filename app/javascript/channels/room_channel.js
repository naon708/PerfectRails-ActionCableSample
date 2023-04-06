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
    alert(data['message']);
  },

  speak: function(message) {
    // サーバーサイドのspeakメソッドをWebSocket経由で呼び出す
    return this.perform('speak', { message: message });
  }
});
