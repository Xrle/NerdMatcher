class ExploreController < ApplicationController
  before_action :check_db_not_empty

  def index
    get_next
  end

  def like
    Like.create(user_id: @current_user.id, liked_id: session[:displayed_user])
    #Check if other person has disliked you
    dislike = @current_user.disliked_by.where('user_id == ' + @current_user.id.to_s)
    if dislike != nil
      dislike.destroy
    end
    update
  end

  def dislike
    Dislike.create(user_id: @current_user.id, disliked_id: session[:displayed_user])
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
      q = sample_users
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
      #Get a fresh sample in the event all ids in the queue are invalid or the queue is empty
      elsif q == []
        q = sample_users
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
  #
  # Points 1, 2, 3, 6 and 7 are covered by this function. Points 4 and 5 are in the like and dislike logic.
  def sample_users
    #Init array, we're going to attempt to find a sample of 10 people, ideally 5 of which have liked you.
    q = []

    #First try to find people that liked you
    @current_user.liked_by.sample(5).each.pluck(:user_id) do |id|
      q << id
      puts("Liked")
      puts(q)
    end

    #Populate the rest with unseen people excluding the current user, disliked people, matches and the current contents of q
    disliked = @current_user.disliked.pluck(:disliked_id)
    User.where.not(id: @current_user.id).where.not(id: disliked).where.not(id: @current_user.matched).where.not(id: q).order(Arel.sql('RANDOM()')).limit(10 - q.size).pluck(:id).each do |id|
      q << id
      puts("Unseen")
      puts(q)
    end

    #We could now fill any remaining quota by including disliked people, however if excluding disliked people leaves q empty,
    # get_next will just call this function again and the dislikes will no longer be valid.

    #Remove dislikes
    @current_user.disliked.each do |dislike|
      dislike.destroy
    end

    #Return shuffled array
    q.shuffle
  end

end
