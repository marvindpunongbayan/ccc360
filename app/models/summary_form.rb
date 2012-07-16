require_dependency Qe::Engine.root.join('app', 'models', 'qe', 'answer_sheet').to_s

class SummaryForm < Qe::AnswerSheet
  self.table_name = "pr_summary_forms"

  belongs_to :review

  def question_sheets
    [ review.question_sheet.summary_form ]
  end

  def can_view?(p)
    return p.admin? || p == review.initiator
  end

  def submit!
  end

  def collat_title
    review.initiator
  end
end
