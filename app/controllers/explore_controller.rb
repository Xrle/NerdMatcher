class ExploreController < ApplicationController
  before_action :check_db_not_empty

  def index
    get_next
  end

  def like
    #Like.create(user_id: @current_user.id, person_id: session[:current_person])
    #Check if other person has disliked you
    #Dislike.find_by()
    update
  end

  def dislike
    #Dislike.create(user_id: @current_user.id, person_id: session[:current_person])
    update
  end

  private
  #Check that users other than the current user exist in the database
  def check_db_not_empty
    if User.count == 1
      if User.first.id == @current_user.id
        render 'empty_db' and return
      end
    end
  end

  #Call get_next and return js to update the view
  def update
    get_next
    respond_to do |format|
      format.js { render :update, layout: false }
    end
  end

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

    #Get next user from queue
    done = false
    until done
      #Try to find next user
      user = User.find_by(id: q.pop)
      #Exit loop if valid person found
      if user != nil
        @user = user
        #Save user id to session
        session[:displayed_user] = user.id
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
  # 6) Exclude yourself from the sample (of course)
  # 7) Don't show people that you have matched with
  def sample_people
    q = [1,2,3]



  end
end
