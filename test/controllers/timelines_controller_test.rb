require 'test_helper'

class TimelinesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get timelines_index_path
    assert_response :success
  end

  test 'should show microposts on timeline' do
    get timelines_index_path
    assert_response :success
    micropost = Micropost.last
    assert_select "li#micropost-micropost_#{micropost.id}"
    assert_match micropost.content, response.body
    assert_match micropost.user_email, response.body
  end
end
