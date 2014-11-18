class ScheduleItem < ActiveRecord::Base
  belongs_to :event

  before_validation do
    self.start_time.strip! if self.start_time.kind_of?(String)
    self.end_time.strip! if self.end_time.kind_of?(String)
    parse_datetime_strings
  end

  validates :start_date, :end_date, timeliness: true
  validates :start_time, :end_time,
    format: { with: /\A([01]?\d|2[0-3]):[0-5]\d\z/, allow_blank: nil }

  validate do
    if starts_at && ends_at && starts_at >= ends_at
      if starts_at.to_date > ends_at.to_date
        errors.add(:end_date, :invalid)
      else
        errors.add(:end_time, :invalid)
      end
    end
  end

  attr_writer :start_date, :end_date, :start_time, :end_time

  def start_date
    @start_date ||= starts_at.try(:strftime, '%Y-%m-%d')
  end

  def end_date
    @end_date ||= ends_at.try(:strftime, '%Y-%m-%d')
  end

  def start_time
    @start_time ||= starts_at.try(:strftime, '%H:%M')
  end

  def end_time
    @end_time ||= ends_at.try(:strftime, '%H:%M')
  end

  private

  def parse_datetime_strings
    if start_date && start_time
      begin
        self.starts_at = Time.zone.parse("#{start_date} #{start_time}")
      rescue ArgumentError
      end
    end

    if end_date && end_time
      begin
        self.ends_at = Time.zone.parse("#{end_date} #{end_time}")
      rescue ArgumentError
      end
    end
  end
end
