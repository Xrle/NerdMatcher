class ExploreController < ApplicationController
  def index
    get_next
  end

  #Get the next person to be shown to the user
  def get_next
=begin
    count = Person.count
    #Init seen array if undefined
    session[:seen] ||= []
    #Reset if everyone has been seen
    if session[:seen].length >= count
      session[:seen].clear
    end

    #Get next unseen person at random
    found = false
    id = nil
    until found
      id = rand(1..count)
      unless session[:seen].include?(id)
        found = true
      end
    end
=end
    #Init unseen array or repopulate if empty
    #@unseen ||= []
    if @unseen == nil
      @unseen = []
    end
    if @unseen.length == 0
      @unseen = [*1..Person.count]
    end

    #Get next unseen person at random
    @person = Person.find_by(id: @unseen.delete_at(rand(@unseen.length)))
  end

  def like

  end

  def dislike

  end
end
