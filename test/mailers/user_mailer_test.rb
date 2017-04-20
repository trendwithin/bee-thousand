require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  test "account_registration" do
    user = users(:vic)
    mail = UserMailer.account_registration user
    assert_equal "Account Activation", mail.subject
    assert_equal ["vic@theshield.net"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Bee Thousand Account Registration", mail.body.encoded
  end

end
