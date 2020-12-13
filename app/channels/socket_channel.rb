class SocketChannel < ApplicationCable::Channel
  def subscribed
    #Give each user their own stream
    user_id = connection.session[:user_id]
    if user_id != nil
      stream_for user_id
    else
      reject
    end
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def message_read(data)
    message = Message.find_by(id: data['message_id'].to_i)
    if message != nil
      #Check user is the intended recipient
      user_id = connection.session[:user_id]
      if message.target_id == user_id
        #Mark as read
        message.update(read: true)
      end
    end

  end

end
