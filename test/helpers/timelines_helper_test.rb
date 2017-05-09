require 'test_helper'

class TimelinesHelperTest < ActionView::TestCase
  test 'liked post font color is red' do
    liked_micropost = microposts(:newest)
    not_liked = microposts(:two)
    fake_view = Object.new

    class << fake_view
      include TimelinesHelper

      def current_user
        User.find_by(email: 'ronnie@theshield.net')
      end

      def liked?(micropost)
        'red' if current_user.likes?(micropost)
      end
    end

    assert_equal 'red', fake_view.liked?(liked_micropost)
    assert_nil fake_view.liked?(not_liked)
  end
end
