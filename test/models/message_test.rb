require 'test_helper'

class MessageTest < ActiveSupport::TestCase
  def setup
    @user1 = users(:one)
    @user2 = users(:two)
    @message = Message.new(user_id: @user1.id, target_id: @user2.id, content: 'test message')
  end

  test "create valid message" do
    assert @message.valid?
  end

  test "invalid no user_id" do
    @message.user_id = nil
    refute @message.valid?
    assert_not_nil @message.errors[:user_id], 'saved without user_id'
  end

  test "invalid no target_id" do
    @message.target_id = nil
    refute @message.valid?
    assert_not_nil @message.errors[:target_id], 'saved without target_id'
  end

  test "invalid no content" do
    @message.content = nil
    refute @message.valid?
    assert_not_nil @message.errors[:content], 'saved without content'
  end

  test "invalid foreign keys" do
    #Use arbitrarily high ids
    message = Message.new(user_id: 500, target_id: 600, content: 'test')
    refute message.valid?
    assert_not_nil message.errors[:user_id]
    assert_not_nil message.errors[:target_id]
  end
end
