module PunditConcerns
  extend ActiveSupport::Concern

  included do
    rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  end

  private
  def user_not_authorized
    self.response_body = nil
    flash[:alert] = 'A problem has occured.  Please email Admin if you feel this in error.'
    redirect_to(request.referrer || root_path)
  end

end
