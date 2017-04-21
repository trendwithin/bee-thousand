class PagesController < ApplicationController
  layout "page"
  before_action :authenticate_user!, except: :welcome
  def welcome
  end

  def registered
  end

  def about
  end
end
