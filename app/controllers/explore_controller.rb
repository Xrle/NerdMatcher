class ExploreController < ApplicationController
  def index
    get_next
  end

  def like
    update
  end

  def dislike
    update
  end

  private

  def update
    get_next
    respond_to do |format|
      format.js { render :update, layout: false }
    end
  end

  private
  #Get the next person to be shown to the user
  def get_next
    q = @current_user.queue
    #Init queue if empty
    q ||= []
    if q == []
      q = sample_people
      puts("new sample")
      puts(q)
    end
    puts("before")
    puts(q)
    #Get next person from queue
    done = false
    until done
      #Try to find next person
      person = Person.find_by(id: q.pop)
      #Exit loop if valid person found
      if person != nil
        @person = person
        done = true
      #Get a fresh sample in the event all ids in the queue are invalid
      elsif q == []
        q = sample_people
      end
    end

    #Save updated queue
    @current_user.queue = q
    @current_user.save
    puts("after")
    puts(q)
  end

  # Generate a sample of people to be shown to the user.
  # The algorithm runs on these principles:
  # 1) Show some people that like you.
  # 2) Show some people that haven't seen you yet
  # 3) Disliking someone eliminates them from consideration for the next sample
  # 4) Liking someone that has disliked you makes it possible for them to see you in the next sample
  # 5) Liking or disliking someone that likes you removes their like flag on you
  def sample_people
    [1, 2, 3]
  end

end
