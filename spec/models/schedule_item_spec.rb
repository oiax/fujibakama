require 'rails_helper'

RSpec.describe ScheduleItem, :type => :model do
  let(:event) { create(:event) }

  describe 'validations' do
    let(:options) do
      {
        start_date: '2015-01-01', start_time: '09:00',
        end_date: '2015-01-01', start_time: '11:00'
      }
    end

    example '不正な日付文字列を拒否する' do
      si = event.schedule_items.build(options.merge(start_date: '20xx-01-00'))
      expect(si).not_to be_valid
      expect(si.errors[:start_date]).not_to be_empty
    end

    example '不正な時刻文字列を拒否する' do
      si = event.schedule_items.build(options.merge(start_time: 'xx:yy'))
      expect(si).not_to be_valid
      expect(si.errors[:start_time]).not_to be_empty
    end
  end
end
