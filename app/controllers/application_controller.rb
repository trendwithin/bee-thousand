class ApplicationController < ActionController::Base
  include Pundit
  include PunditConcerns
  protect_from_forgery with: :exception
end
