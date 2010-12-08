class PeopleController < ApplicationController
  before_filter :get_person, :only => [ :show, :update, :impersonate ]
  before_filter :has_permission, :only => [ :show, :edit ]

  def impersonate
    if admin? && !session[:impersonating]
      session[:user_id2] = session[:user_id]
      session[:user_id] = @person.user.id 
      session[:impersonating] = true
    end
    redirect_to home_url
  end

  def index
    if team_leader?
      team_ids = current_person.team_members.find_all_by_is_leader(true).collect &:teamID
      @leading_ministries = Team.find team_ids, :include => { :people => :subjected_reviews }
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
    @limit = 50
    if !admin? && !team_leader?
      render :inline => ""
    elsif !admin? && team_leader?
      index
      if params[:name] == ""
        @search_filter_label = "Members of the team you are leading according to the Infobase (#{@leading_ministries_names.join(", ")})"
      else
        @search_filter_label = "'#{params[:name]}'"
      end

      @search_people_filter = @team_members.collect(&:personID)
    elsif admin?
      @search_filter_label = "all people"
    end
    super
    if @people.length == @limit
      @search_filter_label += " (limited to #{@limit} results)"
    end
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
