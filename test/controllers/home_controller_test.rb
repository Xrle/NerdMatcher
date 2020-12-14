require 'test_helper'

class HomeControllerTest < ActionDispatch::IntegrationTest
  test "get index" do
    get root_url
    assert_response :success
    assert_select 'h1.title', I18n.t('home.index.welcome')
  end

  test "login when already logged in" do
    log_in
    get login_url
    assert_redirected_to explore_path
  end

  test "log in page" do
    get login_url
    assert_response :success
    assert_select 'p.title', I18n.t('home.login')
  end

  test "log out" do
    log_in
    get logout_url
    assert_redirected_to root_path
    follow_redirect!
    assert_select 'span#notify', /#{I18n.t('home.logout_notice')}/
  end

  test "auth" do
    post login_url, params: {username: 'bob', password: 'bob'}
    assert_not_nil session[:user_id]
    assert_redirected_to explore_path
  end

  test "auth bad password" do
    post login_url, params: {username: 'bob', password: 'adwda'}
    assert_equal I18n.t('home.auth.incorrect_password'), flash[:error]
    assert_redirected_to login_path
  end

  test "auth bad user" do
    post login_url, params: {username: 'wada', password: 'adwda'}
    assert_equal I18n.t('home.auth.user_not_exists'), flash[:error]
    assert_redirected_to login_path
  end

  test "skip auth check" do
    get explore_url
    assert_redirected_to root_path
    follow_redirect!
    assert_select 'span#notify', /#{I18n.t('login_error')}/
  end

  test "should get contact" do
    get contact_url
    assert_response :success
    assert_template layout: 'application'

    assert_select 'p.title', I18n.t('home.contact.title')
  end

  test "should send email" do
    post contact_url, params: {name: 'Bob', email: 'bob@bob.com', message: 'test'}
    assert_redirected_to contact_path
    follow_redirect!
    assert_select 'span#notify', /#{I18n.t('home.send_contact_email.email_sent')}/
  end

  test "blank contact" do
    post contact_url
    assert_redirected_to contact_path
    follow_redirect!
    assert_select 'span#notify', /#{I18n.t('home.send_contact_email.blank_email')}/
    assert_select 'span#notify', /#{I18n.t('home.send_contact_email.blank_name')}/
    assert_select 'span#notify', /#{I18n.t('home.send_contact_email.blank_message')}/
  end

  test "invalid email" do
    post contact_url, params: {name: 'Bob', email: 'bob', message: 'test'}
    assert_redirected_to contact_path
    follow_redirect!
    assert_select 'span#notify', /#{I18n.t('home.send_contact_email.invalid_email')}/
  end


end
