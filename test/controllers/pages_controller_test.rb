require 'test_helper'

class PagesControllerTest < ActionDispatch::IntegrationTest
  test "should get welcome" do
    get root_path
    assert_response :success
  end

  test 'Should have Sign Up Button' do
    get root_path
    assert_response :success
    assert_select 'a[href=?]', new_user_registration_path, 'Sign Up'
  end
end
