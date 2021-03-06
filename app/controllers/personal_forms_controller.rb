class PersonalFormsController < AnswerSheetsController
  before_filter :get_person
  before_filter :has_permission, :unless => :going_to_redirect?
  skip_before_filter :get_answer_sheet, :only => [ :edit ]
  prepend_before_filter :setup_show, :only => [ :show ]
  layout :set_layout

  def edit
    if params[:q] == 'true' 
      f = @person.personal_forms.find_or_create_by_question_sheet_id params[:id]
      redirect_to edit_personal_form_url(f)
    else
      @questionnaire = true
      @personal_form = PersonalForm.find params[:id]
      @answer_sheet_type = 'PersonalForm'
      params[:answer_sheet_type] = @answer_sheet_type
      get_answer_sheet
      super
    end
  end

  protected
  
    def going_to_redirect?
      params[:q] == 'true'
    end

    def get_person
      if params[:person_id]
        @person = Person.find params[:person_id]
      elsif params[:q] == 'true'
        @person = current_person
      else
        @personal_form = PersonalForm.find params[:id]
        @person = @personal_form.person
      end
    end

    def has_permission
      unless can_see_person?(@person)
        error_and_go_home("You don't have permission to view this form.")
      end
    end

    def setup_show
      @answer_sheet_type = 'PersonalForm'
      params[:answer_sheet_type] = @answer_sheet_type
    end
end
