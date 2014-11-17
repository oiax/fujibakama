class ScheduleItem < ActiveRecord::Base
  belongs_to :event

  validate do
    begin
      Date.parse(start_date.to_s) if start_date
    rescue ArgumentError
      errors.add(:start_date, :invalid)
    end

    begin
      Date.parse(end_date.to_s) if end_date
    rescue ArgumentError
      errors.add(:end_date, :invalid)
    end

    begin
      Date.parse("1970-01-01 #{start_time}") if start_time
    rescue ArgumentError
      errors.add(:start_time, :invalid)
    end

    begin
      Date.parse("1970-01-01 #{end_time}") if end_time
    rescue ArgumentError
      errors.add(:end_time, :invalid)
    end
  end

  before_save do
    if start_date && start_time
      self.starts_at = Time.zone.parse("#{start_date} #{start_time}")
    end
    if end_date && end_time
      self.ends_at = Time.zone.parse("#{end_date} #{end_time}")
    end
  end

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
