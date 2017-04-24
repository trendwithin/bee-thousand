class PagesController < ApplicationController
  layout "page"
  before_action :authenticate_user!, only: :registered
  def welcome
  end

  def registered
  end

  def about
  end

  def testimonial
  end
end
