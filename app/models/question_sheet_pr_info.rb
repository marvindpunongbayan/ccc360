class QuestionSheetPrInfo < ActiveRecord::Base
  set_table_name "pr_question_sheet_pr_infos"

  belongs_to :question_sheet
  belongs_to :summary_form, :class_name => "QuestionSheet"

  validate :validate_form_type_change

  def validate_form_type_change
    if form_type_changed?
      if @form_type_before == "review" && question_sheet.reviews.present?
        errors.add_to_base "Could not change type because there are #{question_sheet.reviews.count} reviews already using this form."
      elsif @form_type_before == "personal" && question_sheet.personal_forms.present?
        errors.add_to_base "Could not change type because there are #{question_sheet.personal_forms.count} personal forms already using this form."
      end
    end
  end

  def form_type=(v)
    @form_type_before = form_type
    super
  end

  def questionnaire_type
    if personal
      return "Personal Form"
    elsif summary
      return "Summary Form"
    else
      "Review Form"
    end
  end

  def personal
    form_type == "personal"
  end

  def summary
    form_type == "summary"
  end

  def review
    form_type.nil? || form_type == "review"
  end
end
