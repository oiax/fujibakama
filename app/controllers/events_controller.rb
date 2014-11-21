class EventsController < ApplicationController
  def index
    @events = Event.order(:starts_at, :prefecture_id).page(params[:page]).per(10)
  end

  def new
    @event = Event.new
    @event.schedule_items.build
    @event_form = EventForm.new(@event)
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

  def create
    @event = Event.new
    @event_form = EventForm.new(@event)
    if @event_form.update_attributes(params[:event_form])
      redirect_to action: 'index'
    else
      render action: 'new'
    end
  end

  def destroy
    event = Event.find(params[:id])
    event.destroy
    redirect_to action: 'index'
  end
end
