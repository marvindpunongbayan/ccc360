class PeopleController < ApplicationController
  before_filter :get_person, :only => [ :show, :update ]
  before_filter :has_permission, :only => [ :show, :edit ]

  def index
    if team_leader?
      team_ids = current_person.ministry_missional_team_members.find_all_by_is_leader(true).collect &:teamID
      @leading_ministries = MinistryLocalLevel.find team_ids, :include => { :people => :subjected_reviews }
      @leading_ministries_names = @leading_ministries.collect &:name
      @team_members = @leading_ministries.collect(&:people).flatten
    end
  end

  def show
    @person = Person.find params[:id]
    set_personal_question_sheets
  end

  def update
    if params[:admin] && admin?
      set_admin = params[:admin] == 'true'
      if set_admin
        Admin.find_or_create_by_person_id @person.id
      else
        @person.admin.destroy if @person.admin
      end
      @set_admin = true
      @removed_self = @person == current_person
    end
  end

  def search
    @limit = 20
    if !admin? && !team_leader?
      render :inline => ""
    elsif !admin? && team_leader?
      index
      @search_filter = @leading_ministries_names.join(", ")
      @search_people_filter = @team_members.collect(&:personID)
    else
      @search_filter = "all people"
    end
    super
  end

  protected

    def get_person
      @person = Person.find params[:id]
    end

    def has_permission
      unless can_see_person?(@person)
        no_permission
      end
    end

end
