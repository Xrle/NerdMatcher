require 'test_helper'

class DislikeTest < ActiveSupport::TestCase
  def setup
    @user1 = users(:one)
    @user2 = users(:two)
    @dislike = Dislike.new(user_id: @user1.id, disliked_id: @user2.id)
  end

  test "create valid dislike" do
    assert @dislike.valid?
  end

  test "invalid no user_id" do
    @dislike.user_id = nil
    refute @dislike.valid?
    assert_not_nil @dislike.errors[:user_id], 'saved without user_id'
  end

  test "invalid no disliked_id" do
    @dislike.disliked_id = nil
    refute @dislike.valid?
    assert_not_nil @dislike.errors[:disliked_id], 'saved without disliked_id'
  end

  test "invalid foreign keys" do
    #Use arbitrarily high ids
    dislike = Dislike.new(user_id: 500, disliked_id: 600)
    refute dislike.valid?
    assert_not_nil dislike.errors[:user_id]
    assert_not_nil dislike.errors[:dislike_id]
  end
end
