class ApplicationController < ActionController::Base
  before_action :check_logged_in

  private
  #Check that the user is logged in to a valid account
  def check_logged_in
    if User.find_by(id: session[:userid]) == nil
      flash[:error] = t('login_error')
      redirect_to '/'
    end
  end
end
