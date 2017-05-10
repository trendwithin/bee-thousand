class AlertsController < ApplicationController
  before_action :authenticate_user!
  after_action :verify_authorized

  def create
    @alert = current_user.alerts.build(alert_params)
    authorize @alert
    if @alert.save
      flash[:notice] = 'Alert Posted Successfully.'
      redirect_to timelines_index_path
    else
      @micropost = Micropost.new
      @microposts = Micropost.all
      @alerts = Alert.all
      render 'timelines/index', layout: 'timeline'
    end
  end

  def destroy
  end

  private
    def alert_params
      params.require(:alert).permit(:symbol, :entry, :stop, :target, :shares, :comment)
    end
end
