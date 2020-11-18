class ApplicationController < ActionController::Base
  before_action :check_logged_in

  private
  def check_logged_in
    if session[:userid] == nil
      redirect_to '/'
    end
  end
end
