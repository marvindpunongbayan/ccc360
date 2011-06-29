class ReviewersController < AnswerSheetsController
  skip_before_filter :check_valid_user, :only => [ :edit_from_code, :edit ]
  before_filter :check_valid_user_local, :only => [ :edit ]
  before_filter :get_review, :except => [ :edit_from_code ]
  before_filter :get_reviewer, :only => [ :edit, :show, :destroy, :uncomplete ]
  before_filter :check_permission, :only => [ :edit, :show ]
  prepend_before_filter :set_answer_sheet_type
  before_filter :base_url, :only => [ :create ]
  prepend_before_filter :setup_collate
  layout :set_layout

  def submit
  end

  def destroy
    @reviewer.destroy
    @review.update_percent_and_completed
  end

  def new
    @reviewer = @review.reviewings.new
  end

  def create
    unless @reviewer = @review.reviewings.where(params[:reviewer]).limit(1).first
      @reviewer = @review.reviewings.new params[:reviewer]
      if @reviewer.save
        InvitesMailer.reviewer_invite(@reviewer, "Reviewer Invite").deliver
      end
    end
    @review.update_percent_and_completed
  end

  def uncomplete
    @reviewer.submitted_at = nil
    @reviewer.save!
    @review.update_percent_and_completed
    redirect_to home_url
  end

  def search
    @limit = 50
    super
    #@people -= @review.reviewings.collect(&:person)
  end

  def edit
    @answer_sheet_type = 'Reviewer'
    params[:answer_sheet_type] = @answer_sheet_type
    super
    @questionnaire = true
  end

  def edit_from_code
    @reviewer = Reviewer.where(:access_key => params[:code]).first
    # force people with users to log in
    # if !current_person.present? && @reviewer && @reviewer.person.user.present?
    #   check_valid_user
    #   return unless current_user.present?
    # end

    # if current_person.present? && (@reviewer.person.nil? || @reviewer.person != current_person)
    #   flash[:notice] = "Sorry, that review link is for someone else.  Click the Logout button then click the link again."
    #   redirect_to '/'
    #   return
    # end

    if @reviewer
      # log the person in
      session[:person_id] = @reviewer.person.try(:id)
      session[:user_id] = @reviewer.person.try(:user).try(:id)

      # redirect to filling out the form
      @review = @reviewer.review
      if @review.nil? && Review.unscoped.find(@reviewer.review_id)
        render :text => "This review has been deleted.", :layout => true
      elsif @review.completed_at || @reviewer.submitted_at
        redirect_to review_reviewer_url(@review.id, @reviewer.id)
      else
        redirect_to edit_review_reviewer_url(@review.id, @reviewer.id)
      end
    else
      render :text => "We couldn't find the review that you're looking for. If you've already submitted the review, the link from the email will no longer work. Please ask whoever initiated the review to send you a new invitation.", :layout => true
    end
  end

  def show
    if params[:collate]
      @collating = true
      @collated_answer_sheets = { 
        @answer_sheet => @review.reviewings,
      }
      if @answer_sheet.review.summary_form && @answer_sheet.review.summary_form.question_sheets.present?
        @collated_answer_sheets[@answer_sheet.review.summary_form] = [ @answer_sheet.review.summary_form ]
      end
    end
    @answer_sheets = [ @answer_sheet, @answer_sheet.review.summary_form ].compact
    @questionnaire = true
  end

  protected

    def check_valid_user_local
      unless session[:person_id].present?
        return check_valid_user
      end
      return true
    end

    def get_review
      @review = Review.unscoped.find params[:review_id]
      if @review.fake_deleted
        render :text => "This review has been deleted.", :layout => true
      end
    end

    def get_reviewer
      @reviewer = Reviewer.find params[:id]
    end

    def set_answer_sheet_type
      params[:answer_sheet_type] = 'Reviewer'
    end

    def setup_collate
      if params[:collate]
        get_review
        unless @review.reviewings.present?
          error_and_try_back("Sorry, there are no reviewers yet.  Try again after some reviewers are added.")
          return
        end
        params[:id] = @review.reviewings.first.id
      end
    end

    def check_permission
      unless has_permission
        error_and_try_back("Sorry, you don't have permission to view this review.")
      end
    end

    def has_permission
      return true if @reviewer.person == current_person && params[:collate] != true
      return false if @review.subject == current_person
      return true if @review.initiator == current_person
      return true if is_leading_person?(@review.subject)
      return admin?
    end
end
