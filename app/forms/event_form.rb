class EventForm
  include ActiveModel::Model

  attr_accessor :event, :schedule_items

  delegate :persisted?, to: :event

  def initialize(event)
    @event = event
    @schedule_items = event.schedule_items
  end

  def update_attributes(params)
    @params = params
    event.assign_attributes(event_params)
    schedule_item_params.fetch(:schedule_items).each_value do |attributes|
      id = attributes.delete(:id).to_i
      item = schedule_items.detect { |i| i.id == id }
      item.assign_attributes(attributes)
    end

    if valid?
      ActiveRecord::Base.transaction do
        event.save!
        schedule_items.map(&:save!)
      end
    end
  end

  def valid?
    ([ event ] + schedule_items).all? { |obj| obj.valid? }
  end

  private

  def event_params
    @params.require(:event).permit(:title, :prefecture_id, :venue)
  end

  def schedule_item_params
    @params.permit(
      schedule_items: [ :id, :start_date, :start_time, :end_date, :end_time ])
  end
end
