class EventsController < ApplicationController
  def index
    @events = Event.order(:id).page(params[:page]).per(10)
  end

  def edit
    @event = Event.find(params[:id])
    @event_form = EventForm.new(@event)
  end

  def update
    @event = Event.find(params[:id])
    @event_form = EventForm.new(@event)
    if @event_form.update_attributes(params[:event_form])
      redirect_to action: 'index'
    else
      render action: 'edit'
    end
  end
end
