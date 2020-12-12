require 'test_helper'

class HomeControllerTest < ActionDispatch::IntegrationTest
  #test "should get index" do
  # get home_index_url
  #  assert_response :success
  #end

  test 'should get contact' do
    get contact_url
    assert_response :success
    assert_template layout: 'application'

    assert_select 'p.title', 'Contact Us'
  end
end
