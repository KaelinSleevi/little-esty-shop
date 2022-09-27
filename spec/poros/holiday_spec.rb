require './app/poros/holiday'
require 'rails_helper'

RSpec.describe Holiday do
  describe 'attributes' do
    it 'has a name and a date' do
      holiday_data = {name: 'Halloween',
              date: '10/31/2022'}

      holiday = Holiday.new(holiday_data)

      expect(holiday).to be_instance_of(Holiday)
      expect(holiday.name).to eq('Halloween')
      expect(holiday.date).to eq('10/31/2022')
    end
  end
end