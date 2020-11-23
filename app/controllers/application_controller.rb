class ApplicationController < ActionController::Base
  #All other controllers will inherit this filter
  before_action :check_logged_in

  private
  #Check that the user is logged in to a valid account
  def check_logged_in
    #Will return nil if the user is not logged in or if the user is logged into an account that does not exist
    if User.find_by(id: session[:userid]) == nil
      flash[:error] = t('login_error')
      redirect_to '/'
    end
  end
end
