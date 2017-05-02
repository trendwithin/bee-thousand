require 'test_helper'

class TimelinesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  attr_reader :admin, :registered

  def setup
    @admin = users(:vic)
    @registered = users(:ronnie)
  end

  test "should redirect index when not registered" do
    get timelines_index_path
    assert_response :redirect
  end

  test 'should show microposts on timeline' do
    sign_in registered
    get timelines_index_path
    assert_response :success
    micropost = Micropost.last
    assert_select "li#micropost-micropost_#{micropost.id}"
    assert_match micropost.content, response.body
    assert_match micropost.user_email, response.body
  end
end
