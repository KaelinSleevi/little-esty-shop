require "rails_helper"
require "./app/service/holiday_service"


RSpec.describe(HolidayService) do
  it("can the next three holidays") do
    allow(HolidayService).to(receive(:get_holidays).and_return([{date: '10/31/2022', name: "Halloween"}, {date: '12/25/2022', name: "Thanksgiving"}, {date: '12/25/2023', name: "Christmas"}]))
    holidays = HolidayService.get_holidays
    expect(holidays).to(be_an(Array))
    expect(holidays[0]).to(be_a(Hash))
    expect(holidays[0]).to(have_key(:name))
  end

  it("can get uri") do
    allow(HolidayService).to(receive(:get_uri).and_return([{date: '10/31/2022', name: "Halloween"}, {date: '12/25/2022', name: "Thanksgiving"}, {date: '12/25/2023', name: "Christmas"}]))
    holidays = HolidayService.get_uri("https://date.nager.at/api/v3/NextPublicHolidays/us")
    expect(holidays).to(be_an(Array))
    expect(holidays[0]).to(be_a(Hash))
    expect(holidays[0]).to(have_key(:name))
  end
end
