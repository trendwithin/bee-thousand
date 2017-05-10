class MicropostsController < ApplicationController
  before_action :authenticate_user!
  after_action :verify_authorized

  def create
    @micropost = current_user.microposts.build(micropost_params)
    authorize @micropost
    if @micropost.save
      flash[:notice] = 'Posted Successfully.'
      redirect_to timelines_index_path
    else
      @microposts = Micropost.all
      @alert = Alert.new
      @alerts = Alert.all
      render 'timelines/index', layout: 'timeline'
    end
  end

  def destroy
    @micropost = Micropost.find(params[:id])
    authorize @micropost
    @micropost.destroy
    redirect_to timelines_index_path, notice: 'Post Deleted.'
  end

  private
    def micropost_params
      params.require(:micropost).permit(:content)
    end
end
