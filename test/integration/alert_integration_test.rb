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

  test 'admin user creates a new trader alert' do
    sign_in @admin
    get timelines_index_path
    assert_response :success
    assert_difference 'Alert.count' do
      post alerts_path, params: { alert: { symbol: 'ABCD', entry: '100' } }
    end
  end
end
