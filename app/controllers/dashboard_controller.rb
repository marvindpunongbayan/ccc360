class DashboardController < ApplicationController
  def index
    @reviews = current_person.participating_reviews
  end
end
