require 'test_helper'

class MicropostTest < ActiveSupport::TestCase
  def setup
    @user = users(:vic)
    @micropost = @user.microposts.build(content: 'Lorem Lorax')
  end

  test 'should be valid' do
    assert @micropost.valid?
  end

  test 'user is should be present' do
    @micropost.user_id = nil
    assert_not @micropost.valid?
  end

  test 'content should be present' do
    @micropost.content = ''
    assert_not @micropost.valid?
  end
end
