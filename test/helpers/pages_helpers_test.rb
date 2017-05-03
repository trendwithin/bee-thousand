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
end
