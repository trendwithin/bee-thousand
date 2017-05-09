class Microposts::LikesController < ApplicationController
  before_action :set_micropost
  before_action :authenticate_user!

  def create
    @micropost.likes.where(user_id: current_user.id).first_or_create
    respond_to do |format|
      format.html { redirect_to timelines_index_path }
      format.js
    end
  end

  private
  def set_micropost
    @micropost = Micropost.find(params[:micropost_id])
  end
end
