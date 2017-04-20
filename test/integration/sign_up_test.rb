require 'test_helper'

class SignUpTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test 'Successful Sgnup of User' do
    get new_user_registration_path
    assert_response :success
    assert_equal '/users/sign_up', path
    assert_difference 'User.count', 1 do
      post user_registration_path, params: { user: { email: 'signuptest@example.com', password: 'password' } }
    end
  end
end
