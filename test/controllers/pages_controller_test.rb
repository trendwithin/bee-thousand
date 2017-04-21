require 'test_helper'

class PagesControllerTest < ActionDispatch::IntegrationTest
  test "should get welcome" do
    get root_path
    assert_response :success
  end

  test 'Should have Sign Up Button' do
    get root_path
    assert_response :success
    assert_select 'a.btn', text: 'Sign Up', path: '/users/sign_up'
  end
end
