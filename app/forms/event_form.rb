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
      if id = attributes.delete(:id)
        item = schedule_items.detect { |i| i.id == id.to_i }
        item.assign_attributes(attributes)
      else
        event.schedule_items.build(attributes)
      end
    end

    if valid?
      ActiveRecord::Base.transaction do
        event.save!
        schedule_items.map(&:save_or_destroy!)
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
      schedule_items: [
        :id, :start_date, :start_time, :end_date, :end_time, :_destroy
      ])
  end
end
