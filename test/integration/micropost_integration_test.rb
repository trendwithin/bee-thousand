require 'test_helper'

class MicropostIntegrationTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  attr_reader :content, :admin, :registered

  def setup
    @content = 'Micropost Integration Test Content'
    @admin = users(:vic)
    @registered = users(:ronnie)
  end

  test 'should create micropost on timeline' do
    sign_in admin
    get timelines_index_path
    assert_response :success
    content = 'Lorem Lorax Micropost'
    assert_difference 'Micropost.count' do
      post microposts_path, params: { micropost: { content: content } }
    end
    assert_redirected_to timelines_index_path
    follow_redirect!
    assert_match content, response.body
    assert_match 'Posted Successfully.', flash[:notice]
  end

  test 'admin should be able to delete a micropost' do
    sign_in admin
    get timelines_index_path
    assert_response :success
    assert_select 'a',  text: 'Delete'
    first_micropost = Micropost.first
    assert_difference 'Micropost.count', -1 do
      delete micropost_path(first_micropost)
    end
  end

  test 'registered should not be able to delete a micropost' do
    sign_in registered
    get timelines_index_path
    assert_response :success
    assert_select 'a', text: 'Delete', count: 0
  end

  test 'should not create empty micropost on timeline' do
    sign_in admin
    get timelines_index_path
    assert_response :success
    content = ''
    assert_difference 'Micropost.count', 0 do
      post microposts_path, params: { micropost: { content: content } }
    end
    assert_select 'div#error_explanation'
  end

  test 'like count increases when user likes a micropost' do
    sign_in registered
    get timelines_index_path
    assert_select 'a[href=?]', micropost_like_path(microposts(:one))
    assert_difference 'Like.count' do
      post micropost_like_path(microposts(:one))
    end
  end

  test 'user should only like a micropost once' do
    sign_in registered
    get timelines_index_path
    assert_difference 'Like.count' do
      post micropost_like_path(microposts(:one))
    end

    assert_difference 'Like.count', 0 do
      post micropost_like_path(microposts(:one))
    end
  end

  test 'like count increases via ajax post' do
    sign_in registered
    micropost = microposts(:one)
    assert_difference 'Like.count' do
      post micropost_like_path(micropost), xhr: true
    end
  end
end
