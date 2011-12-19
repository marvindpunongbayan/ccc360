class SummaryFormsController < AnswerSheetsController
  skip_before_filter :get_answer_sheet, :only => [ :edit ]
  prepend_before_filter :setup_show
  layout :set_layout

  def edit
    @questionnaire = true
    @review = Review.find(params[:review_id])
    @summary_form = @review.find_or_create_summary_form
    unless @summary_form && @summary_form.review.question_sheet.summary_form
      error_and_try_back("Sorry, no summary form has been chosen for this review.")
      return 
    end
    params[:id] = @summary_form.id
    @answer_sheet_type = 'SummaryForm'
    params[:answer_sheet_type] = @answer_sheet_type
    get_answer_sheet
    super
  end

  protected

    def has_permission
      unless can_view?(current_person)
        error_and_try_back("Sorry, you don't have permission to view this summary.")
      end
    end

    def setup_show
      @questionnaire = true
      @review = Review.find(params[:review_id])
      @summary_form = @review.find_or_create_summary_form
      params[:id] = @summary_form.id if @summary_form
      @answer_sheet_type = 'SummaryForm'
      params[:answer_sheet_type] = @answer_sheet_type
    end

end
