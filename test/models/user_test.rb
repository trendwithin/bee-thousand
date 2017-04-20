require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(email: 'user_test@example.com', password: 'password')
  end

  test 'Valid User' do
     assert @user.valid?
     assert_equal 'pending', @user.registration_status
     assert_equal 'standard', @user.role
  end

  test 'User with Edge Case Password Length' do
    @user.password = '1234567'
    refute @user.valid?
    @user.password = 'a' * 129
    refute @user.valid?
  end
end
