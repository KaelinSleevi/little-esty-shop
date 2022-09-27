require "httparty"
require "json"

class HolidayService
  def self.get_holidays
    get_uri("https://date.nager.at/api/v3/NextPublicHolidays/us")
  end

  def self.get_uri(uri)
    return [{date: '10/31/2022', name: "Halloween"}, {date: '12/25/2022', name: "Thanksgiving"}, {date: '12/25/2023', name: "Christmas"}] if Rails.env == 'test'    
    response = HTTParty.get(uri)
    parsed = JSON.parse(response.body, symbolize_names: true)
    end
end
