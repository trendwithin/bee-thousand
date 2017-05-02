require 'test_helper'

class MicropostsControllerTest < ActionDispatch::IntegrationTest
  attr_reader :content
  def setup
    @content = 'Micropost Controller Test Content'
  end

  test 'successfully create a micropost' do
    assert_difference 'Micropost.count' do
      post microposts_path, params: { micropost: { content: content } }
    end
  end

  test 'successfully deleting a micropost' do
    micropost = Micropost.first
    assert_difference 'Micropost.count', -1 do
      delete micropost_path(micropost)
    end
  end

  test 'empty content does not create a micropost' do
    assert_difference 'Micropost.count', 0 do
      post microposts_path, params: { micropost: { content: '' } }
    end
  end

  test 'blank content does not create a micropost' do
    assert_difference 'Micropost.count', 0 do
      post microposts_path, params: { micropost: { content: '     ' } }
    end
  end
end
