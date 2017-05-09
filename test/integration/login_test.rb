require 'test_helper'

class LoginTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @acct_activation = "Your account is not activated yet."
  end

  test 'invalid login credentials' do
    get new_user_session_path
    assert_response :success
    post user_session_path, params: { user: { email: 'invalid@example.com', password: 'invaliduser' } }
    assert_match 'Invalid Email or password', flash['alert']
  end

  test 'login credentials fail for pending user' do
    pending_user = users(:shane)
    post user_session_path, params: { user: { email: pending_user.email, password: 'password' } }
    assert_match @acct_activation, flash['alert']
  end

  test 'login credentials fail for expired user' do
    expired_user = users(:lem)
    post user_session_path, params: { user: { email: expired_user.email, password: 'password' } }
    assert_match @acct_activation, flash['alert']
  end

  test 'login credentials for valid user' do
    valid_user = users(:vic)
    post user_session_path, params: { user: { email: valid_user.email, password: 'password' } }
    assert_match 'Signed in successfully.', flash[:notice]
    follow_redirect!
    assert_equal timelines_index_path, @request.env['PATH_INFO']
  end
end
