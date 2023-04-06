class RoomChannel < ApplicationCable::Channel
  # 購読後に呼ばれる
  def subscribed
    stream_from "room_channel"
  end

  # 購読解除後に呼ばれる
  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  # クライアントサイドから呼び出された時に実行される
  def speak(data)
    # 受け取ったメッセージをDBに保存
    message = Message.create!(content: data["message"])

    ActionCable.server.broadcast(
      "room_channel", { message: render_message(message) }
    )
  end

  private

  def render_message(message)
    ApplicationController.render( # コントローラー外からテンプレートをレンダリングできる
      # 部分テンプレートから生成したHTMLを送信する
      partial: "messages/message",
      locals: { message: message }
    )
  end
end
