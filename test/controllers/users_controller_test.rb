require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    log_in('bob', 'bob')
  end

  test "should get new" do
    get signup_url
    assert_response :success
  end

  test "should create user" do
    assert_difference('User.count') do
      post signup_url, params: { user: { username: 'fred', password: 'password', password_confirmation: 'password', name: 'Fred George', dob: '11/09/2008', gender: 'male'} }
    end

    assert_redirected_to explore_url
  end

  test "should get edit" do
    get profile_url
    assert_response :success
  end

  test "should update user" do
    patch profile_url, params: { user: { bio: 'test bio'} }
    assert_redirected_to profile_url
    assert_nil flash[:error]
    assert_not_empty flash[:notice]
  end

  test "should destroy user" do
    assert_difference('User.count', -1) do
      delete profile_url
    end

    assert_redirected_to root_url
  end
end
