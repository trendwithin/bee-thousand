class MicropostsController < ApplicationController

  def create
    @micropost = User.first.microposts.build(micropost_params)
    if @micropost.save
      flash[:notice] = 'Posted Successfully.'
      redirect_to timelines_index_path
    else
      @microposts = Micropost.all
      render 'timelines/index', layout: 'timeline'
    end
  end

  def destroy
    @micropost = Micropost.find(params[:id])
    @micropost.destroy
    redirect_to timelines_index_path, notice: 'Post Deleted.'
  end

  private
    def micropost_params
      params.require(:micropost).permit(:content)
    end
end
