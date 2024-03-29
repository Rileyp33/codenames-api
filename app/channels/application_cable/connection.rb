module ApplicationCable
  class Connection < ActionCable::Connection::Base
    # Add secure ws connection. Example with users:
    # identified_by :current_user

    def connect
      # Example:
      # self.current_user = find_verified_user
    end

    # Example:
    # protected
      # def find_verified_user
      #   verified_user = User.find_by(id: cookies.signed['user.id'])
        # if verified_user && cookies.signed['user.expires_at'] > Time.now
        #   verified_user
        # else
        #   reject_unauthorized_connection
        # end
      # end
  end
end