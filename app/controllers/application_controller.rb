class ApplicationController < ActionController::Base
  #All other controllers will inherit these
  before_action :check_logged_in
  before_action :set_user

  private
  #Check that the user is logged in to a valid account
  def check_logged_in
    #Will return nil if the user is not logged in or if the user is logged into an account that does not exist
    user = User.find_by(id: session[:userid])
    if user != nil
      #Save user for use within the app
      @current_user = user

    else
      #Show an error and redirect to home page
      flash[:error] = t('login_error')
      redirect_to '/'
    end

  end

  #Set user if logged in but not on a page requiring logging in
  def set_user
    if @current_user == nil and session[:userid] != nil
      user = User.find_by(id: session[:userid])
      if user != nil
        @current_user = user
      end
    end

  end

end
