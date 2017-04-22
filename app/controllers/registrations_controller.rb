class RegistrationsController < Devise::RegistrationsController
  def create
    super
    if @user.persisted?
      UserMailer.account_registration(@user).deliver
      AdminMailer.user_register_notification.deliver
    end
  end

  protected

  def after_sign_up_path_for(resource)
    pages_registered_path
  end
end
