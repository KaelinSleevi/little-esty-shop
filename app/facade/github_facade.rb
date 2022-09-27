require "./app/service/github_service"
require "./app/poros/holidays"

class GitHubFacade
  def self.holidays
    holiday_data = GitHubService.get_holidays
    holiday_data.map do |holiday_data|
      Holiday.new(holiday_data)
    end
  end
end