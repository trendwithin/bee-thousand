class TimelinesController < ApplicationController
  layout 'timeline'
  def index
    @microposts = Micropost.by_most_recent
  end
end
