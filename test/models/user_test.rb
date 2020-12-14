require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user1 = users(:one)
    @user2 = users(:two)
  end

  test "create valid user" do
    assert @user1.valid?
  end

  test "invalid no username" do
    @user1.username = nil
    refute @user1.valid?
    assert_not_nil @user1.errors[:username], 'saved without username'
  end

  test "invalid no name" do
    @user1.name = nil
    refute @user1.valid?
    assert_not_nil @user1.errors[:name], 'saved without name'
  end

  test "invalid no dob" do
    @user1.dob = nil
    refute @user1.valid?
    assert_not_nil @user1.errors[:dob], 'saved without dob'
  end

  test "invalid no gender" do
    @user1.gender = nil
    refute @user1.valid?
    assert_not_nil @user1.errors[:gender], 'saved without gender'
  end

  test "invalid future dob" do
    @user1.dob = Date.today + 1
    refute @user1.valid?
    assert_equal [I18n.t('user.dob_past')], @user1.errors[:dob], 'saved with future dob'
  end

  test "invalid no password" do
    @user1.password = nil
    refute @user1.valid?
    assert_not_nil @user1.errors[:password], 'saved without password'
  end

  test "invalid password does not match confirmation" do
    @user1.password = "test"
    @user1.password_confirmation = "nose"
    refute @user1.valid?
    assert_not_nil @user1.errors[:password_confirmation], 'saved with non-matching password confirmation'
  end

  test "valid with new password" do
    @user1.password = 'New Password'
    @user1.password_confirmation = 'New Password'
    assert @user1.valid?, 'rejected valid password'
  end

  test "valid set bio" do
    @user1.bio = 'Test bio'
    assert @user1.valid?, 'rejected valid bio'
  end

  test "associations from user" do
    #Create associated records
    assert_difference(%w[Like.count Dislike.count Match.count Message.count Photo.count]) do
      Like.create(user_id: @user1.id, liked_id: @user2.id)
      Dislike.create(user_id: @user1.id, disliked_id: @user2.id)
      Match.create(user_id: @user1.id, matched_id: @user2.id)
      Message.create(user_id: @user1.id, target_id: @user2.id, content: 'Test message')
      Photo.create(user_id: @user1.id, image_data: TestImage.image_data)
    end

    #Now destroy the user and all the other records should be deleted
    assert_difference(%w[User.count Like.count Dislike.count Match.count Message.count Photo.count], -1) do
      @user1.destroy
    end
  end

  test "associations from target" do
    #Create associated records
    assert_difference(%w[Like.count Dislike.count Match.count Message.count Photo.count]) do
      Like.create(user_id: @user1.id, liked_id: @user2.id)
      Dislike.create(user_id: @user1.id, disliked_id: @user2.id)
      Match.create(user_id: @user1.id, matched_id: @user2.id)
      Message.create(user_id: @user1.id, target_id: @user2.id, content: 'Test message')
      Photo.create(user_id: @user2.id, image_data: TestImage.image_data)
    end

    #Now destroy the user and all the other records should be deleted
    assert_difference(%w[User.count Like.count Dislike.count Match.count Message.count Photo.count], -1) do
      @user2.destroy
    end
  end

  test "matches" do
    Match.create(user_id: @user1.id, matched_id: @user2.id)
    assert_equal [@user2.id], @user1.matches, 'user 1 did not get the correct matches'
    assert_equal [@user1.id], @user2.matches, 'user 2 did not get the correct matches'
  end
end
