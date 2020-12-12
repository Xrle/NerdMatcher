class HomeController < ApplicationController
  #These actions can be performed without being logged in
  skip_before_action :check_logged_in, only: [:index, :login, :auth, :contact, :send_contact_email]

  def index
  end

  def login
    #Redirect to explore page if already logged in
    if session[:user_id] != nil
      redirect_to '/explore'
    end
  end

  def logout
    session[:user_id] = nil
    flash[:notice] = t('.logout_notice')

    #Normally clearing upload cache would be handled by a rake task on a cron job.
    # This is impractical for this coursework, so clear the cache when a user logs off instead.
    puts 'Clearing upload cache...'
    Shrine.storages[:cache].clear!
    puts 'Success!'

    redirect_to '/'
  end

  #Stores current user id as a session variable and redirects to /explore if successful.
  def auth
    user = User.find_by(username: params[:username])
    #Check user exists
    if user == nil
      flash[:error] = "User does not exist!"
      redirect_to action: :login and return
    end

    #Check for correct password
    if user.authenticate(params[:password]) == false
      flash[:error] = "Password incorrect!"
      redirect_to action: :login
    else
      session[:user_id] = user.id
      redirect_to '/explore'
    end
  end

  def contact
  end

  def send_contact_email
    name = params[:name]
    email = params[:email]
    message = params[:message]
    errors = []

    #Validate name
    if name.blank?
      errors << "Name can't be blank"
    end

    #validate email
    if email.blank?
      errors << "Email can't be blank"
    elsif email !~ URI::MailTo::EMAIL_REGEXP
      errors << 'Invalid email'
    end

    #Validate message
    if message.blank?
      errors << "Message can't be blank"
    end

    #Either send the email or show the errors
    puts(errors)
    if errors == []
      ContactMailer.contact_email(name, email, message).deliver_now
      flash[:notice] = 'Email sent!'
    else
      flash[:error] = render_to_string :partial => 'contact_errors', :locals => {errors: errors}
    end

    #Refresh the page
    redirect_to action: :contact

  end

end
