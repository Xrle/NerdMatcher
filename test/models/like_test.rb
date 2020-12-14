require 'test_helper'

class LikeTest < ActiveSupport::TestCase
  def setup
    @user1 = users(:one)
    @user2 = users(:two)
    @like = Like.new(user_id: @user1.id, liked_id: @user2.id)
  end

  test "create valid like" do
    assert @like.valid?
  end

  test "invalid no user_id" do
    @like.user_id = nil
    refute @like.valid?
    assert_not_nil @like.errors[:user_id], 'saved without user_id'
  end

  test "invalid no liked_id" do
    @like.liked_id = nil
    refute @like.valid?
    assert_not_nil @like.errors[:liked_id], 'saved without liked_id'
  end

  test "invalid foreign keys" do
    #Use arbitrarily high ids
    like = Like.new(user_id: 500, liked_id: 600)
    refute like.valid?
    assert_not_nil like.errors[:user_id]
    assert_not_nil like.errors[:liked_id]
  end
end
