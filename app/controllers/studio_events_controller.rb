class StudioEventsController < ApplicationController

  def index
    @events = StudioEvent.where(active: true).order(:start_date)
  end
end
