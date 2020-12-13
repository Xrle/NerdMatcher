class ChatController < ApplicationController
  before_action :check_matched, only: [:chat, :show_messages]


  def index
    @matches = User.where(id: @current_user.matches).to_a
  end

  def chat
    @user = User.find_by(id: params[:id])
  end

  def show_messages
    #Get all messages and mark unread ones as read
    @user = User.find_by(id: params[:id])
    sent_messages = @current_user.messages.where("target_id == #{@user.id}")
    received_messages = @current_user.received_messages.where("user_id == #{@user.id}")
    @messages = sent_messages.union_all(received_messages).order('messages.created_at ASC')

    respond_to do |format|
      format.html {render 'show_messages'}
    end

    #Now that messages have been shown, reset unread count
    received_messages.where(read: false).update_all(read: true)

  end

  def send_message
    message = Message.new(user_id: @current_user.id, target_id: params[:id], content: params[:message])
    if message.save
      #Broadcast new messages
      SocketChannel.broadcast_to(@current_user.id, {message_id: 'nil', show_on: message.target_id ,body: render_to_string(:partial => 'message', :locals => {type: 'sent', content: message.content})})
      SocketChannel.broadcast_to(params[:id], {message_id: message.id, show_on: message.user_id, body: render_to_string(:partial => 'message', :locals => {type: 'received', content: message.content})})
    end

    respond_to do |format|
      format.js {render 'clear_form', layout: false}
    end

  end

  def unmatch
  end

  private
  def check_matched
    #Check user has matched with the requested user
    unless @current_user.matches.include?(params[:id].to_i)
      flash[:error] = "You haven't matched with that user!"
      redirect_to action: :index
    end
  end
end
