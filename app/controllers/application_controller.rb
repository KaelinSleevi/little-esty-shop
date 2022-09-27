require "./app/facade/github_facade"

class ApplicationController < ActionController::Base
  before_action :holidays

  private

  def holidays
    @holidays = GitHubFacade.holidays
  end
end
