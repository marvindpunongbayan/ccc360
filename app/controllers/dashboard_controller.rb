class DashboardController < ApplicationController
  skip_before_filter :check_valid_user, :only => [ :logout ]

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
        if reviewing.submitted_at
          @past_team_reviewings << reviewing
        else
          @team_reviewings << reviewing
        end
      else
        if reviewing.submitted_at
          @past_nonteam_reviewings << reviewing
        else
          @nonteam_reviewings << reviewing
        end
      end
    end

    set_personal_question_sheets
  end

  def logout
    if session[:impersonating]
      session[:user_id] = session[:user_id2]
      session[:impersonating] = false
      redirect_to home_url
    else
      session.clear
      redirect_to "https://signin.ccci.org/sso/logout/logout.jsp"
    end
  end
end
