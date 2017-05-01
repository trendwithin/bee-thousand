require 'test_helper'

class MicropostIntegrationTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test 'should create micropost on timeline' do
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

  test 'should not create empty micropost on timeline' do
    get timelines_index_path
    assert_response :success
    content = ''
    assert_difference 'Micropost.count', 0 do
      post microposts_path, params: { micropost: { content: content } }
    end
    assert_select 'div#error_explanation'
  end
end
