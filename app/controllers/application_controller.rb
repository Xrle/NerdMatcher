class ApplicationController < ActionController::Base
  #All other controllers will inherit these
  before_action :check_logged_in
  before_action :set_user

  private
  #Check that the user is logged in to a valid account
  def check_logged_in
    #Will return nil if the user is not logged in or if the user is logged into an account that does not exist
    user = User.find_by(id: session[:user_id])
    if user != nil
      #Save user for use within the app
      @current_user = user

    else
      #Clear user_id in case the user was logged in to an account that no longer exists to prevent issues
      session[:user_id] = nil
      #Show an error and redirect to home page
      flash[:error] = t('login_error')
      redirect_to '/'
    end

  end

  #Set user if logged in but not on a page requiring logging in
  def set_user
    if @current_user == nil and session[:user_id] != nil
      user = User.find_by(id: session[:user_id])
      if user != nil
        @current_user = user
      else
        #Clear an invalid user_id from session
        session[:user_id] = nil
      end
    end

  end

end
