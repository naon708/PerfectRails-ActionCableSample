require "test_helper"

class RoomChannelTest < ActionCable::Channel::TestCase
  # チャネルのテスト
  test "subscribes" do
    subscribe
    # subscriptionメソッドでRoomChannelオブジェクトを取得できる
    assert subscription.confirmed?
    # room_channelが作成されているかどうか
    assert_has_stream "room_channel"
  end

  # ブロードキャストのテスト
  test "broadcasts" do
    subscribe
    text = "hello"
    broadcast_text = ApplicationController.render(
      partial: 'messages/message',
      locals: { message: Message.new(content: text) }
    )
    assert_broadcast_on('room_channel', message: broadcast_text) do
      # クライアント側からspeakメソッドを呼び出して、渡した文字列を含むHTMLがブロードキャストされたかを確認する
      perform :speak, message: text
    end
  end
end
