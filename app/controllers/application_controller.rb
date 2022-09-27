require "./app/facade/holiday_facade"

class ApplicationController < ActionController::Base
  before_action :holidays

  private

  def holidays
    @holidays = HolidayFacade.holidays
  end
end
