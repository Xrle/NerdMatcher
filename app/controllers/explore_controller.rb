class ExploreController < ApplicationController
  before_action :check_db_not_empty

  def index
    get_next
  end

  def like
    #If the other person disliked you, remove the dislike
    dislike = @current_user.disliked_by.where(user_id: session[:displayed_user]).first
    if dislike != nil
      dislike.destroy
    end

    #Match if the other person liked you too
    like = @current_user.liked_by.where(user_id: session[:displayed_user]).first
    if like != nil
      Match.create(user_id: @current_user.id, matched_id: session[:displayed_user])
      like.destroy
      #Save name of person for notifying user
      @matched_name = User.find_by(id: session[:displayed_user]).name
    else
      #Only create the like if there was no match, otherwise there will be a like and a match recorded
      Like.create(user_id: @current_user.id, liked_id: session[:displayed_user])
    end

    update
  end

  def dislike
    Dislike.create(user_id: @current_user.id, disliked_id: session[:displayed_user])
    #If the other person liked you, remove the like
    like = @current_user.liked_by.where(user_id: session[:displayed_user]).first
    if like != nil
      like.destroy
    end
    update
  end

  def no_users
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
    #Don't render an update if get_next failed
    if @abort
      return
    end
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
    end

    #Get next user from queue
    done = false
    until done
      #Try to find next user
      user = User.find_by(id: q.pop)
      #Exit loop if valid person found
      if user != nil
        @user = user
        @photos = user.photos.to_a
        @photo_count = @photos.size
        #Save user id to session
        session[:displayed_user] = user.id
        done = true
      #Get a fresh sample in the event all ids in the queue are invalid or the queue is empty
      elsif q == []
        q = sample_users
        #If sample_users then returns another empty array, all other users must either be liked or matched, so redirect to an error page
        # If somebody was just matched with, save their name to flash
        if q == []
          @abort = true
          if @matched_name != nil
            flash[:success] = t('.matched', name: @matched_name)
          end
          redirect_to action: :no_users and return
        end
      end
    end

    #Save updated queue
    @current_user.queue = q
    @current_user.save
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
    #Size of the sample to produce
    sample_size = 10

    #Number of people that liked you to try and include, should be < sample_size
    liked_quota = 5

    #Init array
    q = []

    #First try to find people that liked you
    q.concat(@current_user.liked_by.sample(liked_quota).pluck(:user_id))

    #Populate the rest with unseen people excluding the current user, liked people, disliked people, matches and the current contents of q
    likes = @current_user.likes.pluck(:liked_id)
    dislikes = @current_user.dislikes.pluck(:disliked_id)
    exclude = []
    exclude.concat(q, likes, dislikes, @current_user.matches, [@current_user.id])
    q.concat(User.where.not(id: exclude).order(Arel.sql('RANDOM()')).limit(sample_size - q.size).pluck(:id))

    #We could now fill any remaining quota by including disliked people, however if excluding disliked people leaves q empty,
    # get_next will just call this function again and the dislikes will no longer be valid.

    #Remove dislikes
    @current_user.dislikes.destroy_all

    #Return shuffled array
    q.shuffle
  end

end
