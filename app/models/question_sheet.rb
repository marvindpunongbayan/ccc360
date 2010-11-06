require_dependency "vendor/plugins/questionnaire_engine/app/models/question_sheet.rb"

class QuestionSheet < ActiveRecord::Base
  has_one :question_sheet_pr_info, :dependent => :destroy

  after_save do |record|
    unless record.question_sheet_pr_info
      record.question_sheet_pr_info = QuestionSheetPrInfo.new :question_sheet_id => self.id
    end
    record.question_sheet_pr_info.save!
  end

  def personal
    question_sheet_pr_info.personal
  end

  def personal=(v)
    question_sheet_pr_info.personal = v
  end
end
