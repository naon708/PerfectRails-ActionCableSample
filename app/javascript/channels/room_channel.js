import consumer from "./consumer"

consumer.subscriptions.create("RoomChannel", {
  // 接続時
  connected() {
    document.
      querySelector('input[data-behavior="room_speaker"]').
      addEventListener('keypress', (event) => {
        // テキスト入力欄でEnterキーを押されたらspeakメソッドを呼び出す
        if (event.key === 'Enter') {
          this.speak(event.target.value);
          event.target.value = '';
          return event.preventDefault();
        }
      });
  },

  // 切断時
  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  // サーバーからデータを受信した時
  received(data) {
    // メッセージを受け取ったらDOMを書き換える
    const element = document.querySelector('#messages')
    element.insertAdjacentHTML('beforeend', data['message'])
  },

  speak: function(message) {
    // サーバーサイドのspeakメソッドをWebSocket経由で呼び出す
    return this.perform('speak', { message: message });
  }
});
