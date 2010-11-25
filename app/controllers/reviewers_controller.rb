class ReviewersController < AnswerSheetsController
  skip_before_filter :check_valid_user, :only => [ :edit_from_code ]
  before_filter :get_review, :except => [ :edit_from_code ]
  before_filter :get_reviewer, :only => [ :edit, :show, :destroy, :uncomplete ]
  before_filter :check_permission, :only => [ :edit, :show ]
  prepend_before_filter :set_answer_sheet_type
  before_filter :base_url, :only => [ :create ]
  prepend_before_filter :setup_collate

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
      @reviewer.save
      InvitesMailer.reviewer_invite(@reviewer).deliver
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
    @people -= @review.reviewings.collect(&:person)
  end

  def edit
    @answer_sheet_type = 'Reviewer'
    params[:answer_sheet_type] = @answer_sheet_type
    super
    @questionnaire = true
  end

  def edit_from_code
    @reviewer = Reviewer.where(:access_key => params[:code]).first
    if @reviewer
      # log the person in
      session[:user_id] = @reviewer.person.user.id

      # redirect to filling out the form
      @review = @reviewer.review
      if @review.completed_at || @reviewer.submitted_at
        redirect_to review_reviewer_url(@review.id, @reviewer.id)
      else
        redirect_to edit_review_reviewer_url(@review.id, @reviewer.id)
      end
    else
      render :text => "Couldn't find review with code #{params[:code]}."
    end
  end

  def show
    if params[:collate]
      params[:collate_ids] = (@review.reviewings.collect(&:id) - [ @reviewer.id ]).join(',')
    end
    get_collated_answer_sheets
    super
    @questionnaire = true
  end

  protected

    def get_review
      @review = Review.find params[:review_id]
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
          flash[:error] = "Sorry, there are no reviewers yet.  Try again after some reviewers are added."
          if request.env["HTTP_REFERER"]
            redirect_to :back
          else
            render :text => "", :layout => true
          end
        end
        params[:id] = @review.reviewings.first.id
      end
    end

    def check_permission
      unless has_permission
        flash[:error] = "Sorry, you don't have permission to view this review."
        if request.env["HTTP_REFERER"]
          redirect_to :back
        else
          render :text => "", :layout => true
        end
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
