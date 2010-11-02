class ReviewersController < AnswerSheetsController
  before_filter :get_review
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
