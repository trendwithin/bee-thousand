class RegistrationsController < Devise::RegistrationsController
  def create
    super
    if @user.persisted?
      byebug
      UserMailer.account_registration(@user) # .deliver
    end
  end
end
