require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    log_in
  end

  test "should get new" do
    get signup_url
    assert_response :success
    assert_select 'p.title', I18n.t('home.signup')
  end

  test "should create user" do
    assert_difference('User.count') do
      post signup_url, params: { user: { username: 'fred', password: 'password', password_confirmation: 'password', name: 'Fred George', dob: '11/09/2008', gender: 'male'} }
    end

    assert_redirected_to explore_url
    follow_redirect!
    assert_select '#current-user', I18n.t('partials.header.logged_in', name: 'Fred George')

  end

  test "should get edit" do
    get profile_url
    assert_response :success
    assert_select 'p.title', I18n.t('users.edit.title')
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
    assert_equal I18n.t('users.delete_success'), flash[:notice]

    assert_redirected_to root_url
  end
end
