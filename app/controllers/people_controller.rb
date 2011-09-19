class PeopleController < ApplicationController
  before_filter :get_person, :only => [ :show, :update, :impersonate ]
  before_filter :has_permission, :only => [ :show, :edit ]

  def new
    @person = Person.new
    names = params[:name].to_s.split(' ')
    @person = Person.new(:firstName => names[0], :lastName => (names[1..-1] || []).join(' '))
    @person.current_address = CurrentAddress.new
    @review = Review.find params[:review_id]
  end

  def create
    params[:person] ||= {}
    params[:person][:current_address] ||= {}
    @review = Review.find params[:review_id]
    @current_address = CurrentAddress.new(params[:person].delete(:current_address).merge({:addressType => 'current'}))
    @person = Person.new(params[:person])
    @person.current_address = @current_address

    [:firstName, :lastName].each do |c|
      @person.errors.add_on_blank(c)
    end

    [:email].each do |c|
      @current_address.errors.add_on_blank(c)
    end

    if @current_address.email.present? && person_exists = Address.find_by_email(@current_address.email).try(:person)
      @current_address.errors.add_to_base({ :email_exists => person_exists })
    end

    unless !@current_address.errors.present? && @current_address.valid? && 
      !@person.errors.present? && @person.valid?
      render :new
    else
      @person.save!
      @current_address.save!
      render(:update) do |page|
        page << %|
          $.ajax({ url: "#{review_reviewers_url(@review.id, "reviewer[person_id]" => @person.id, :close_person_dialog => true, :format => "js", :method => :post)}", type: "POST" });
        |
      end
    end
  end

  def impersonate
    if admin? && !session[:impersonating]
      session[:user_id2] = session[:user_id]
      session[:user_id] = @person.user.id 
      session[:impersonating] = true
    end
    redirect_to home_url
  end

  def index
    @team_members = []
    if team_leader?
      team_ids = current_person.team_members.find_all_by_is_leader(true).collect &:teamID
      @leading_ministries = Team.find team_ids, :include => { :people => :subjected_reviews }
      @leading_ministries_names = @leading_ministries.collect &:name
      @team_members += @leading_ministries.collect(&:people).flatten.uniq
    end
    @team_members += people_in_access_level
    @team_members.uniq!
  end

  def show
    @person = Person.find params[:id]
    if admin? && !@person.staff.present?
      flash[:error] = "This person is not in Peoplesoft, so they can't be assigned advanced permissions."
    end

    set_personal_question_sheets
  end

  def update
    if params[:access] == "admin"
      if admin?
        set_admin = params[:value] == 'true'
        if set_admin
          Admin.find_or_create_by_person_id @person.id
        else
          @person.admin.destroy if @person.admin
        end
        @set_admin = true
        @removed_self = @person == current_person
      end
    elsif params[:access] == "jobstatus"
      access = @person.get_person_access
      access.ics_access = false
      access.intern_access = false
      access.stint_access = false
      if params[:value] == "stint_and_intern"
        access.stint_access = true
        access.intern_access = true
      elsif params[:value].present?
        access.send("#{params[:value]}_access=", true)
      end
      access.save!
    elsif params[:access] == "jobtitle"
      access = @person.get_person_access
      access.mtl_access = false
      if params[:value].present?
        access.mtl_access = true
      end
      access.save!
    elsif params[:access]
      @person.get_person_access.send("#{params[:access]}_access=", params[:value] == 'true')
      @person.get_person_access.save!
    end
  end

  def search
    @limit = 50
    @people_in_access_level = people_in_access_level
    if !admin? && (!team_leader? && @people_in_access_level.empty?)
      render :inline => ""
    elsif !admin? && (team_leader? || @people_in_access_level.present?)
      index
      if params[:name] == ""
        @search_filter_label = "Members of the team you are leading according to the Infobase (#{@leading_ministries_names.join(", ")})#{" and your level of access" if @person.try(:person_access).any_access_set}"
      else
        @search_filter_label = "'#{params[:name]}'"
      end

      @search_people_filter = @team_members.collect(&:personID)

      # also include people in access level
      @search_people_filter = @search_people_filter | @people_in_access_level.collect(&:personID)

    elsif admin?
      @search_filter_label = "all people"
    end
    @search_filter_label ||= ""
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
