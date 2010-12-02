require_dependency "#{Rails.root}/vendor/plugins/questionnaire_engine/app/models/question_sheet.rb"

class QuestionSheet < ActiveRecord::Base
  has_one :question_sheet_pr_info, :dependent => :destroy
  has_many :reviews
  has_many :personal_forms

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

  def self.all_review_forms
    QuestionSheetPrInfo.where(:form_type => [ nil, 'review' ]).includes(:question_sheet).collect(&:question_sheet)
  end
end
