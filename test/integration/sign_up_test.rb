require 'test_helper'

class SignUpTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test 'Successful Sign Up of User' do
    get new_user_registration_path
    assert_response :success
    assert_equal '/users/sign_up', path
    assert_difference 'User.count', 1 do
      post user_registration_path, params: { user: { email: 'signuptest@example.com', password: 'password' } }
    end
    user = User.find_by(email: 'signuptest@example.com')
    assert_equal 'pending', user.registration_status
  end
end
