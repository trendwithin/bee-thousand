require 'test_helper'

class AlertsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  attr_reader :content, :admin, :registered

  def setup
    @registered = users(:ronnie)
  end

  test 'unauthorized cannot create a trade alert' do
    assert_difference 'Alert.count', 0 do
      post alerts_path, params: { alert: { symbol: 'TEST', entry: '111' } }
    end
  end

  test 'registered user cannot create a trade alert' do
    sign_in @registered
    assert_difference 'Alert.count', 0 do
      post alerts_path, params: { alert: { symbol: 'TEST', entry: '111' } }
    end
  end
end
