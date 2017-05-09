require 'test_helper'
require 'minitest/mock'

class PagesHelperTest < ActionView::TestCase
  attr_reader :items

  def setup
    @urls = ['/pages/contact', '/pages/about', '/pages/testimonial']
    @titles = ['Contact', 'About', 'Testimonials']
  end

  test 'nav_items returns expected urls' do
    nav = nav_items
    nav.each do |elem|
      assert_equal true, @urls.include?(elem[:url])
    end
  end

  test 'nav_items returns expected titles' do
    nav = nav_items
    nav.each do |elem|
      assert_equal true, @titles.include?(elem[:title])
    end
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
