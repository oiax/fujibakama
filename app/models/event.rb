class Event < ActiveRecord::Base
  belongs_to :prefecture
  has_many :schedule_items, dependent: :destroy
end
