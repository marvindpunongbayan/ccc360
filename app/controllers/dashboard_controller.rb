class DashboardController < ApplicationController
  def index
    @reviews = pr_user.participating_reviews
  end
end
