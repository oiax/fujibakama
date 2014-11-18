FactoryGirl.define do
  factory :schedule_item do
    event
    starts_at Time.zone.local(2015, 1, 1, 10)
    ends_at Time.zone.local(2015, 1, 1, 17)
  end
end
