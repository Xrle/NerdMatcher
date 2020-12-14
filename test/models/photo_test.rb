require 'test_helper'

class PhotoTest < ActiveSupport::TestCase
  def setup
    @photo = Photo.new(user_id: users(:one).id, image_data: TestImage.image_data)
  end

  test "create valid photo" do
    @photo.image_data
    assert @photo.valid?
  end

  test "invalid no user_id" do
    @photo.user_id = nil
    refute @photo.valid?
    assert_not_nil @photo.errors[:user_id], 'saved without user_id'
  end

  test "invalid no image_data" do
    @photo.image_data = nil
    refute @photo.valid?
    assert_not_nil @photo.errors[:image_data], 'saved without image data'
  end

  test "invalid foreign key" do
    #Use arbitrarily high ids
    photo = Photo.new(user_id: 500, image_data: TestImage.image_data)
    refute photo.valid?
    assert_not_nil photo.errors[:user_id]
  end
end
