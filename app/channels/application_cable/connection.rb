module ApplicationCable
  class Connection < ActionCable::Connection::Base
    #Make session available to socket to get current user
    def session
      @request.session
    end
  end
end
