class SummaryForm < AnswerSheet
  belongs_to :review
  set_table_name "pr_summary_forms"

  def question_sheets
    [ review.question_sheet.summary_form ]
  end

  def can_view?(p)
    return p.admin? || p == review.initiator
  end

  def submit!
  end
end
