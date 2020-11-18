class HomeController < ApplicationController
  skip_before_action :check_logged_in

  def index
  end

  def login

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
