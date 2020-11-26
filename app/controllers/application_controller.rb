class ApplicationController < ActionController::Base
  #All other controllers will inherit these
  before_action :check_logged_in
  before_action :set_vars

  private
  #Check that the user is logged in to a valid account
  def check_logged_in
    #Will return nil if the user is not logged in or if the user is logged into an account that does not exist
    user = User.find_by(id: session[:userid])
    if user != nil
      #Save username for use within the app
      @current_username = user.name

    else
      #Show an error and redirect to home page
      flash[:error] = t('login_error')
      redirect_to '/'
    end

  end

  #Setup any variables required globally
  def set_vars
    #Set @current_username if logged in on a page where logging in is not required
    if @current_username == nil and session[:userid] != nil
      user = User.find_by(id: session[:userid])
      if user != nil
        @current_username = user.name
      end
    end

  end

end
