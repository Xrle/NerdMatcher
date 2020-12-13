class SocketChannel < ApplicationCable::Channel
  def subscribed
    #Give each user their own stream
    stream_for connection.session[:user_id]
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def messages
  end
end
