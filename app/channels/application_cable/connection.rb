module ApplicationCable
  class Connection < ActionCable::Connection::Base
    # current_user および current_user= が作成される
    identified_by :current_user

    def connect
      self.current_user = find_verified_user
    end

    private

    def find_verified_user
      if verified_user = User.find_by(id: cookies.signed[:user_id])
        verified_user
      else
        # WebSocket接続を取りやめるためのメソッド
        reject_unauthorized_connection
      end
    end
  end
end
