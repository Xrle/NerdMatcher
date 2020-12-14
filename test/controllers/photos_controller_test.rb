require 'test_helper'

class PhotosControllerTest < ActionDispatch::IntegrationTest
  setup do
    log_in
  end

  test "should get new" do
    get profile_photos_upload_url
    assert_response :success
    assert_select 'form'
  end

  test "should create photo" do
    assert_difference('Photo.count') do
      post profile_photos_upload_url, params: { photo: {image: fixture_file_upload('files/image.jpg', 'image/jpeg') } }
    end

    assert_redirected_to profile_photos_path
    follow_redirect!
    assert_select 'img'

    #Clean up photo
    delete profile_photos_url, params: {photo_id: Photo.first.id}

  end

  test "should destroy photo" do
    photo = Photo.create(user_id: users(:one).id, image_data: TestImage.image_data)
    assert_difference('Photo.count', -1) do
      delete profile_photos_url, params: {photo_id: photo.id}
    end

    assert_equal I18n.t('photos.deleted'), flash[:notice]
    assert_redirected_to profile_photos_url
  end
end
