require 'test_helper'

class MatchTest < ActiveSupport::TestCase
  def setup
    @user1 = users(:one)
    @user2 = users(:two)
    @match = Match.new(user_id: @user1.id, matched_id: @user2.id)
  end

  test "create valid match" do
    assert @match.valid?
  end

  test "create invalid reversed match" do
    @match.save
    match = Match.new(user_id: @user2.id, matched_id: @user1.id)
    refute match.valid?
    assert_not_nil match.errors[:match], 'saved match when reverse already exists'
  end

  test "invalid no user_id" do
    @match.user_id = nil
    refute @match.valid?
    assert_not_nil @match.errors[:matched_id], 'saved without user_id'
  end

  test "invalid no matched_id" do
    @match.matched_id = nil
    refute @match.valid?
    assert_not_nil @match.errors[:matched_id], 'saved without matched_id'
  end

  test "invalid foreign keys" do
    #Use arbitrarily high ids
    match = Match.new(user_id: 500, matched_id: 600)
    refute match.valid?
    assert_not_nil match.errors[:user_id]
    assert_not_nil match.errors[:matched_id]
  end
end
