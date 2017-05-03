class ApplicationController < ActionController::Base
  include Pundit
  include PunditConcerns
  protect_from_forgery with: :exception

  protected
    def after_sign_in_path_for(resource)
      timelines_index_path
    end
end
