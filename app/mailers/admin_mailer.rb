class AdminMailer < ApplicationMailer
  def user_register_notification
    mail to: 'admin@example.com', subject: 'User Registration Notification'
  end
end
