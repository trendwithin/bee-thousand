require 'test_helper'

class PagesControllerTest < ActionDispatch::IntegrationTest
  test "should get welcome" do
    get root_path
    assert_response :success
  end

  test 'Should have Sign Up/Learn More Button' do
    get root_path
    assert_response :success
    assert_select 'a[href=?]', new_user_registration_path, 'Sign Up'
    assert_select 'a[href=?]', pages_about_path, 'Learn More'
  end

  test 'Should Have Contact About Testimonials Login Links' do
    get root_path
    assert_select 'a[href=?]', pages_contact_path, 'Contact'
    assert_select 'a[href=?]', pages_about_path, 'About'
    assert_select 'a[href=?]', pages_testimonial_path, 'Testimonials'
    assert_select 'a[href=?]', new_user_session_path, 'Login'
  end

  test 'Should Not Have Logout Unless Signed In' do
    get root_path
    assert_response :success
    assert_select 'a[href=?]', destroy_user_session_path, count: 0
  end
end
