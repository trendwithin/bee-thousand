require 'test_helper'

class MicropostIntegrationTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @admin = users(:vic)
    @registered = users(:ronnie)
  end

  test 'new trade form for admin user on timelines_index_path' do
    h_tag = 'New Trade Alert'
    sign_in @admin
    get timelines_index_path
    assert_response :success
    assert_match h_tag, @response.body
    assert_match 'form', @response.body
    assert_match 'new_alert', @response.body
  end

  test 'new trade form does not render for registered users' do
    sign_in @registered
    get timelines_index_path
    assert_response :success
    refute_match 'new_alert', @response.body
  end

  test 'admin user creates a new trader alert' do
    sign_in @admin
    get timelines_index_path
    assert_response :success
    assert_difference 'Alert.count' do
      post alerts_path, params: { alert: { symbol: 'ABCD', entry: '100' } }
    end
  end

  test 'new trade alert viewable on timelines/index' do
    sign_in @admin
    get timelines_index_path
    post alerts_path, params: { alert: { symbol: 'ABCD', entry: '100' } }
    follow_redirect!
    assert_equal 'Alert Posted Successfully.', flash[:notice]
    assert_match 'ABCD', @response.body
  end

  test 'new trade alert errors out with incorrect data' do
    sign_in @admin
    get timelines_index_path
    post alerts_path, params: { alert: { symbol: '', entry: '' } }
    assert_match '2 errors prohibited this post from being saved', @response.body
  end
end
