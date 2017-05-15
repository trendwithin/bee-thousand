class UserTimelinesController < ApplicationController
  before_action :authenticate_user!

  def show
    user = User.find(params[:id])
    @microposts = user.microposts
  end
end
