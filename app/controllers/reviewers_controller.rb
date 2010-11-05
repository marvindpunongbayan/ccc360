class ReviewersController < AnswerSheetsController
  skip_before_filter :check_valid_user, :only => [ :edit_from_code ]
  before_filter :get_review, :except => [ :edit_from_code ]
  before_filter :get_reviewer, :only => [ :edit, :show ]
  prepend_before_filter :set_answer_sheet_type

  def new
    @reviewer = @review.reviewer_wrappers.new
  end

  def create
    @reviewer = @review.reviewer_wrappers.new params[:reviewer]
    @reviewer.save
  end

  def search
    @limit = 7
    super
  end

  def edit
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
      redirect_to edit_review_reviewer_url(@review.id, @reviewer.id)
    else
      render :text => "Couldn't find review from code #{params[:code]}"
    end
  end

  def show
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

end
