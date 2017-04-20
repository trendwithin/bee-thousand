class UserMailer < ApplicationMailer
  def account_registration user
    @greeting = "Welcome"
    @user = user

    mail to: user.email, subject: 'Account Activation'
  end
end
