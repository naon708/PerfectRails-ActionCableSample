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
    ActionCable.server.broadcast(
      "room_channel", { message: data["message"] }
    )
  end
end
