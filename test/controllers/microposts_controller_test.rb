require 'test_helper'

class MicropostsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  attr_reader :content, :admin, :registered

  def setup
    @content = 'Micropost Controller Test Content'
    @admin = users(:vic)
    @registered = users(:ronnie)
  end

  test 'admin user successfully creates a micropost' do
    sign_in admin
    assert_difference 'Micropost.count' do
      post microposts_path, params: { micropost: { content: content } }
    end
  end

  test 'registered user successfully creates a micropost' do
    sign_in registered
    assert_difference 'Micropost.count' do
      post microposts_path, params: { micropost: { content: content } }
    end
  end

  test 'non-credentialed user can not create a micropost' do
    assert_difference 'Micropost.count', 0 do
      post microposts_path, params: { micropost: { content: content } }
    end
  end

  test 'admin user successfully deleting a micropost' do
    sign_in admin
    micropost = Micropost.first
    assert_difference 'Micropost.count', -1 do
      delete micropost_path(micropost)
    end
  end

  test 'registered user not authorized to delete a micropost' do
    sign_in registered
    micropost = Micropost.first
    assert_difference 'Micropost.count', 0 do
      delete micropost_path(micropost)
    end
  end

  test 'non-credentialed user not authorized to delete a micropost' do
    micropost = Micropost.first
    assert_difference 'Micropost.count', 0 do
      delete micropost_path(micropost)
    end
  end

  test 'empty content does not create a micropost' do
    sign_in registered
    assert_difference 'Micropost.count', 0 do
      post microposts_path, params: { micropost: { content: '' } }
    end
  end

  test 'blank content does not create a micropost' do
    sign_in registered
    assert_difference 'Micropost.count', 0 do
      post microposts_path, params: { micropost: { content: '     ' } }
    end
  end
end
