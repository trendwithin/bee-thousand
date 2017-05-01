class TimelinesController < ApplicationController
  layout 'timeline'
  def index
    @microposts = Micropost.by_most_recent
    @micropost = Micropost.new
  end
end
