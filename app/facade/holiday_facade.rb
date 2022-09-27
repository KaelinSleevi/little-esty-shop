require "./app/service/holiday_service"
require "./app/poros/holiday"

class HolidayFacade
  def self.holidays
    holiday_data = HolidayService.get_holidays
    holiday_data.map do |holiday_data|
      Holiday.new(holiday_data)
    end
  end
end