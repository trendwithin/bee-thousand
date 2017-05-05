require 'test_helper'
require 'minitest/mock'

class PagesHelperTest < ActionView::TestCase
  attr_reader :items

  def setup
    @items = [
              {
                url: pages_contact_path,
                title: 'Contact'
              },
              {
                url: pages_about_path,
                title: 'About'
              },
              {
                url: pages_testimonial_path,
                title: 'Testimonials'
              }
          ]
  end

  test 'nav_items returns correct values' do
   assert_equal items, nav_items
  end

  test 'active? page returns true for current_page?' do
    fake_view = Object.new
    class << fake_view
      include PagesHelper

      def current_page?(path)
        path == 'pages/about'
      end
    end
    assert_equal 'active', fake_view.active?('pages/about')
    assert_nil fake_view.active?('pages/other')
  end # Thanks for the test suggestion Chris Kottom!
end
