class DashboardController < ApplicationController
  def index
    reviews = current_person.participating_reviews
    team_members = current_person.team_members
    @nonteam_reviews = []
    @team_reviews = []
    @past_nonteam_reviews = []
    @past_team_reviews = []
    for review in reviews
      if team_members.include?(review.subject)
        if review.past?
          @past_team_reviews << review
        else
          @team_reviews << review
        end
      else
        if review.past?
          @past_nonteam_reviews << review
        else
          @nonteam_reviews << review
        end
      end
    end
  end
end
