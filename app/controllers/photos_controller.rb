class PhotosController < ApplicationController
  def index
    @photos = @current_user.photos.to_a
  end

  def new
    @photo = Photo.new
  end

  def create
    @photo = Photo.new(photo_params)
    @photo.user_id = @current_user.id

    respond_to do |format|
      if @photo.save
        format.html { redirect_to '/profile/photos', notice: t('.uploaded') }
      else
        flash.now[:error] = render_to_string :partial => 'partials/errors', :locals => {model: @photo}
        format.html { render :new }
      end
    end
  end

  def destroy
    #If the photo is contained in this relation, the user has permission to destroy it
    photo = @current_user.photos.find_by(id: params[:photo_id])
    respond_to do |format|
      if photo != nil
        photo.destroy
        format.html { redirect_to '/profile/photos', notice: t('.deleted') }
      else
        flash[:error] = t('.delete_denied')
        format.html { redirect_to '/profile/photos'}
      end
    end
  end

  private
  def photo_params
    params.require(:photo).permit(:image)
  end
end
