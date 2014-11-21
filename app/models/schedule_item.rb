class ScheduleItem < ActiveRecord::Base
  belongs_to :event

  before_validation do
    self.start_time.strip! if self.start_time.kind_of?(String)
    self.end_time.strip! if self.end_time.kind_of?(String)
    self.starts_at = parse_datetime_strings(start_date, start_time)
    self.ends_at = parse_datetime_strings(end_date, end_time)
  end

  validates :start_date, :end_date, date_string: true
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
  attr_accessor :_destroy

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

  def save_or_destroy!
    if _destroy == '1'
      destroy if persisted?
    else
      save!
    end
  end

  private

  def parse_datetime_strings(date, time)
    if date && time
      begin
        Time.zone.parse("#{date} #{time}")
      rescue ArgumentError
      end
    end
  end
end
