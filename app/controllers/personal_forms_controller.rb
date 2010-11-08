class PersonalFormsController < AnswerSheetsController
  before_filter :get_person
  before_filter :has_permission
  skip_before_filter :get_answer_sheet, :only => [ :edit ]

  def edit
    if params[:q] == 'true' 
      f = @person.personal_forms.find_or_create_by_question_sheet_id params[:id]
      redirect_to edit_personal_form_url(f)
    else
      @questionnaire = true
      @personal_form = PersonalForm.find params[:id]
      params[:answer_sheet_type] = 'PersonalForm'
      get_answer_sheet
      super
    end
  end

  protected

    def get_person
      if params[:person_id]
        @person = Person.find params[:person_id]
      else
        @person = current_person
      end
    end

    def has_permission
      unless can_see_person?(@person)
        no_permission
      end
    end
end