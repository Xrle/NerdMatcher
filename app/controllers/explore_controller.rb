class ExploreController < ApplicationController
  def index

  end

  #Get the next person to be shown to the user
  def get_next
    count = Person.count
    #Init seen array if undefined
    session[:seen] ||= []
    #Reset if everyone has been seen
    if session[:seen].length >= Person.count
      session[:seen].clear
    end
    #Get next person

  end
end
