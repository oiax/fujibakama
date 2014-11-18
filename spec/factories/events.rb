FactoryGirl.define do
  factory :event do
    prefecture { Prefecture.first }
    title 'Title'
    venue 'Venue'
  end
end
