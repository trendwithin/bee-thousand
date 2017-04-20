class RegistrationsController < Devise::RegistrationsController
  def create
    super
    if @user.persisted?
      UserMailer.account_registration(@user)
    end
  end
end
