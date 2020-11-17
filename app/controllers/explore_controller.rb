class ExploreController < ApplicationController
  def index
    get_next
  end

  def like
    #Refactor explore to partial and swap whole thing in
    get_next
    render :update
    #respond_to do |format|
    #  format.js { render :update}
    #end
  end

  def dislike
    get_next
    render :update
    #respond_to do |format|
    #  format.js { render :update}
    #end
  end

  private
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
      puts('init')
      @unseen = []
    end
    if @unseen.length == 0
      puts('populate')
      @unseen = [*1..Person.count]
    end
    puts(@unseen)

    #Get next unseen person at random
    @person = Person.find_by(id: @unseen.delete_at(rand(@unseen.length)))
    puts(@unseen)
  end


end
