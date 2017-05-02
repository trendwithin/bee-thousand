class ApplicationController < ActionController::Base
  include Pundit
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  protect_from_forgery with: :exception

  private
  def user_not_authorized
    self.response_body = nil
    flash[:alert] = 'A problem has occured.  Please email Admin if you feel this in error.'
    redirect_to(request.referrer || root_path)
  end
end
