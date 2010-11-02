class DashboardController < ApplicationController
  def index
    reviewings = current_person.reviewings
    team_members = current_person.team_members
    @nonteam_reviewings = []
    @team_reviewings = []
    @past_nonteam_reviewings = []
    @past_team_reviewings = []
    for reviewing in reviewings
      review = reviewing.review
      next if review.nil?
      if team_members.include?(review.subject)
        if review.past?
          @past_team_reviewings << reviewing
        else
          @team_reviewings << reviewing
        end
      else
        if review.past?
          @past_nonteam_reviewings << reviewing
        else
          @nonteam_reviewings << reviewing
        end
      end
    end
  end
end
