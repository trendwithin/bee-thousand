require 'test_helper'

class SignUpTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    ActionMailer::Base.deliveries.clear
  end

  test 'Successful Sign Up of User' do
    get new_user_registration_path
    assert_response :success
    assert_equal '/users/sign_up', path
    assert_difference 'User.count', 1 do
      post user_registration_path, params: { user: { email: 'signuptest@example.com', password: 'password' } }
    end
    user = User.find_by(email: 'signuptest@example.com')
    assert_equal 'pending', user.registration_status
    assert_equal 'standard', user.role
  end

  test 'User Sign Up: ActionMailer Callback' do
    assert_difference('ActionMailer::Base.deliveries.count', 2) do
      post user_registration_path, params: { user: { email: 'actionmailertest@example.com', password: 'password' } }
      assert_equal 'Account Activation', ActionMailer::Base.deliveries[0].subject
      assert_equal 'User Registration Notification', ActionMailer::Base.deliveries[1].subject 
    end
  end
end
