class HomeController < ApplicationController
  #These actions can be performed without being logged in
  skip_before_action :check_logged_in, only: [:index, :login, :auth]

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
    redirect_to '/'
  end

  #Stores current user id as a session variable and redirects to /explore if successful.
  def auth
    user = User.find_by(name: params[:name])
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

end
