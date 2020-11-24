class HomeController < ApplicationController
  #These actions can be performed without being logged in
  skip_before_action :check_logged_in, only: [:index, :login, :signup, :auth]

  def index
  end

  def login
    #Redirect to explore page if already logged in
    if session[:username] != nil
      redirect_to '/explore'
    end
  end

  def logout
    session[:username] = nil
    flash[:notice] = t('.logout_notice')
    redirect_to '/'
  end

  def signup

  end

  #Stores current username as a session variable if successful.
  #Username can be used instead of user id as user names are unique and more useful
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
      session[:username] = user.name
      redirect_to '/explore'
    end
  end

end
