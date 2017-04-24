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
    follow_redirect!
    assert_equal "Welcome! You have signed up successfully.", flash[:notice]
    assert_equal '/pages/registered', path
    user = User.find_by(email: 'signuptest@example.com')
    assert_equal 'pending', user.registration_status
    assert_equal 'standard', user.role
  end

  test 'Unsuccessful Sing Up of User: Email Already Exist' do
    User.create!(email: 'exist@example.com', password: 'password')
    assert_difference 'User.count', 0 do
      post user_registration_path, params: { user: { email: 'exist@example.com', password: 'password' } }
    end
    assert_match 'Email has already been taken', @response.body
  end

  test 'Unsuccessful Sign Up of User: Too Short Password' do
    get new_user_registration_path
    assert_difference 'User.count', 0 do
      post user_registration_path, params: { user: { email: 'signuptest@example.com', password: 'pass' } }
    end
    assert_match "1 error prohibited this user from being saved:", @response.body
  end

  test 'Unsuccessful Sign Up of User: Too Long Password' do
    get new_user_registration_path
    password = 'a' * 129
    assert_difference 'User.count', 0 do
      post user_registration_path, params: { user: { email: 'signuptest@example.com', password: password } }
    end
    assert_match "1 error prohibited this user from being saved:", @response.body
  end

  test 'User Sign Up: ActionMailer Callback' do
    assert_difference('ActionMailer::Base.deliveries.count', 2) do
      post user_registration_path, params: { user: { email: 'actionmailertest@example.com', password: 'password' } }
      assert_equal 'Account Activation', ActionMailer::Base.deliveries[0].subject
      assert_equal 'User Registration Notification', ActionMailer::Base.deliveries[1].subject
    end
  end

  test 'Failed User Sign Up (Short Password): ActionMailer Empty' do
    assert_difference('ActionMailer::Base.deliveries.count', 0) do
      post user_registration_path, params: { user: { email: 'actionmailertest@example.com', password: 'pass' } }
    end
  end

  test 'Failed User Sign Up (Long Password): ActionMailer Empty' do
    password = 'a' * 129
    assert_difference('ActionMailer::Base.deliveries.count', 0) do
      post user_registration_path, params: { user: { email: 'actionmailertest@example.com', password: password } }
    end
  end
end
