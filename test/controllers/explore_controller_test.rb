require 'test_helper'

class ExploreControllerTest < ActionDispatch::IntegrationTest
  setup do
    log_in('bob', 'bob')
  end

  test "should get index" do
    get explore_url
    assert_response :success
  end

end
