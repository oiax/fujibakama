class EventForm
  include ActiveModel::Model

  attr_accessor :event

  delegate :persisted?, to: :event

  def initialize(event)
    @event = event
  end

  def update_attributes(params)
    @params = params
    event.assign_attributes(event_params)
    if event.valid?
      event.save!
    end
  end

  private

  def event_params
    @params.require(:event).permit(:title, :prefecture_id, :venue)
  end
end
