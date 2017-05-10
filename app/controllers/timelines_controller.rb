class TimelinesController < ApplicationController
  layout 'timeline'
  before_action :authenticate_user!
  def index
    @microposts = Micropost.by_most_recent
    @micropost = Micropost.new
    @alert = Alert.new
    @alerts = Alert.all
  end
end
