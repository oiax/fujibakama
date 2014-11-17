class ScheduleItem < ActiveRecord::Base
  belongs_to :event

  attr_writer :start_date, :end_date, :start_time, :end_time

  def start_date
    @start_date ||= starts_at.strftime('%Y-%m-%d')
  end

  def end_date
    @end_date ||= ends_at.strftime('%Y-%m-%d')
  end

  def start_time
    @start_time ||= starts_at.strftime('%H:%M')
  end

  def end_time
    @end_time ||= ends_at.strftime('%H:%M')
  end
end
