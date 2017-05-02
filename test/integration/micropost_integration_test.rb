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
end
