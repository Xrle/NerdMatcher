class HomeController < ApplicationController
  #These actions can be performed without being logged in
  skip_before_action :check_logged_in, only: [:index, :login, :signup, :auth]

  def index
  end

  def login
    #Redirect to explore page if already logged in
    if session[:userid] != nil
      redirect_to '/explore'
    end
  end

  def logout
    session[:userid] = nil
    flash[:notice] = t('.logout_notice')
    redirect_to '/'
  end

  def signup

  end

  def auth
    user = User.find_by name: params[:name]
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
      session[:userid] = user.id
      redirect_to '/explore'
    end
  end

  private
  def auth_params

  end
end
