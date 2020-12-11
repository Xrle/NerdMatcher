class UsersController < ApplicationController
  #Creating a new user doesn't require logging in otherwise new users wouldn't be able to sign up
  skip_before_action :check_logged_in, only: [:new, :create]
  before_action :set_user, only: [:show]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(new_params)

    respond_to do |format|
      if @user.save
        #Log user in and redirect to explore
        session[:user_id] = @user.id
        format.html { redirect_to '/explore', notice: t('.signup_success') }
      else
        flash.now[:error] = render_to_string :partial => 'partials/errors', :locals => {model: @user}
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @current_user.update(update_params)
        format.html { redirect_to '/account', notice: t('.update_success') }
      else
        flash.now[:error] = render_to_string :partial => 'partials/errors', :locals => {model: @user}
        format.html { render :edit }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @current_user.destroy
    session[:user_id] = nil
    respond_to do |format|
      format.html { redirect_to '/', notice: t('.delete_success') }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Parameters for new user
    def new_params
      params.require(:user).permit(:username, :password, :password_confirmation, :name, :dob, :gender)
    end

    # Parameters for updating user
    # Cannot change username once user is created
    def update_params
      params.require(:user).permit(:password, :password_confirmation, :name, :dob, :gender, :bio)
    end
end
