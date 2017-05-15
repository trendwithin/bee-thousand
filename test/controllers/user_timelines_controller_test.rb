require 'test_helper'

class UserTimelinesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @admin = users(:vic)
    @registered = users(:ronnie)
  end

  test 'should redirect when user not logged in' do
    get user_timeline_path(@admin.id)
    assert_response :redirect
  end

  test 'should #show admin micropost when logged in' do
    sign_in @admin
    get user_timeline_path(@admin)
    assert_response :success
    micropost = microposts(:one)
    assert_match micropost.content, @response.body
  end

  test 'should #show registered user micropost for admin user' do
    sign_in @admin
    get user_timeline_path(@registered) , params: { id: @registered }
    assert_response :success
    micropost = microposts(:two)
    assert_match micropost.content, @response.body
  end

  test 'should #show admin micropost when registed user logged in' do
    sign_in @registered
    get user_timeline_path(@admin)
    assert_response :success
    micropost = microposts(:one)
    assert_match micropost.content, @response.body
  end

  test 'should #show personal micropost when logged in' do
    sign_in @registered
    get user_timeline_path(@registered)
    micropost = microposts(:two)
    assert_match micropost.content, @response.body
  end
end
