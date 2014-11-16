class EventsController < ApplicationController
  def index
    @events = Event.order(:id)
  end
end
