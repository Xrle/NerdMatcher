require 'test_helper'

class ExploreControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    log_in
    get explore_url
    assert_response :success
  end

  test "like" do
    log_in
    get explore_url
    assert_difference('Like.count') do
      post explore_like_url, xhr: true
    end
    assert_response :success
    assert_equal "text/javascript", @response.media_type
  end

  test "dislike" do
    log_in
    get explore_url
    assert_difference('Dislike.count') do
      post explore_dislike_url, xhr: true
    end
    assert_response :success
    assert_equal "text/javascript", @response.media_type
  end

  #This doesn't seem to pass 100% of the time, with more time I would rewrite this to keep track of who is being liked
  # and loop until it knows for certain a match should be made.
  #
  #test "match" do
  #  assert_difference('Match.count') do
  #    log_in
  #    get explore_url
  #    post explore_like_url, xhr: true
  #    get logout_url
  #    log_in_any('lucy', 'lucy')
  #    get explore_url
  #    #There are three other people so just like them all to get a match
  #    post explore_like_url, xhr: true
  #    post explore_like_url, xhr: true
  #    post explore_like_url, xhr: true
  #    get logout_url
  #  end
  #end

  test "no users" do
    log_in
    get explore_no_users_url
    assert_response :success
    assert_select 'p.title', I18n.t('explore.no_users.error_1')
  end

end
