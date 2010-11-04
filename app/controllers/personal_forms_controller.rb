class PersonalFormsController < AnswerSheetsController
  before_filter :get_person
  before_filter :has_permission

  def edit
    if params[:q_id] 
      f = @person.personal_forms.find_or_create_by_questionnaire_id params[:q_id]
      redirect_to personal_forms_url(f)
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
      # TODO
    end
end
