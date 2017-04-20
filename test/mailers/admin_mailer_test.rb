require 'test_helper'

class AdminMailerTest < ActionMailer::TestCase
  test "user_register_notification" do
    mail = AdminMailer.user_register_notification
    assert_equal "User Registration Notification", mail.subject
    assert_equal ["admin@example.com"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "New User Registration Alert", mail.body.encoded
  end

end
