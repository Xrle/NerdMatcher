require 'test_helper'

class ChatControllerTest < ActionDispatch::IntegrationTest
  def setup
    log_in
    @one = users(:one)
    @two = users(:two)
    Match.create(user_id: @one.id, matched_id: @two.id)

  end

  test "get index" do
    get matches_url
    assert_response :success
    assert_select 'p.title', I18n.t('chat.index.title')
  end

  test "get chat" do
    get chat_url, params: {id: @two.id}
    assert_response :success
    assert_select 'p.title', /#{@two.name}/
    assert_select 'iframe'
  end

  test "send message" do
    assert_difference('Message.count') do
      post chat_url, params: {id: @two.id, message: 'test'}, xhr: true
    end
    assert_equal "text/javascript", @response.media_type
  end

  test "show message" do
    Message.create(user_id: @one.id, target_id: @two.id, content: 'Hello!')
    get chat_show_messages_url, params: {id: @two.id}
    assert_response :success
    assert_select 'div', 'Hello!'
  end

  test "unmatch" do
    assert_difference('Match.count', -1) do
      delete matches_url, params: {id: @two.id, name: @two.name}
    end
    assert_redirected_to matches_url
    assert_equal I18n.t('chat.unmatched', name: @two.name), flash[:notice]

  end
end
