class EventsController < ApplicationController
  def index
    @events = Event.order(:id).page(params[:page]).per(10)
  end
end
