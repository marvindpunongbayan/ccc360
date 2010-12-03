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

  def form_type() question_sheet_pr_info.form_type end
  def form_type=(v) question_sheet_pr_info.form_type = v end
  def summary_form() summary_form.form_type end
  def summary_form=(v) summary_form.form_type = v end

  def is_review?() question_sheet_pr_info.review end
  def is_summary?() question_sheet_pr_info.summary end
  def is_personal?() question_sheet_pr_info.personal end

  def personal
    question_sheet_pr_info.personal
  end

  def personal=(v)
    question_sheet_pr_info.personal = v
  end

  def self.all_review_forms
    QuestionSheetPrInfo.where(:form_type => [ nil, 'review' ]).includes(:question_sheet).collect(&:question_sheet)
  end

  def self.all_summary_forms
    QuestionSheetPrInfo.where(:form_type => 'summary').includes(:question_sheet).collect(&:question_sheet)
  end

  def self.all_personal_forms
    QuestionSheetPrInfo.where(:form_type => 'personal').includes(:question_sheet).collect(&:question_sheet)
  end

  def summary_form
    question_sheet_pr_info.summary_form
  end

  def submit
    redirect_to :back
  end
end
