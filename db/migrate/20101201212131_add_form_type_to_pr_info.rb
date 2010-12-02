class AddFormTypeToPrInfo < ActiveRecord::Migration
  def self.up
    add_column "pr_question_sheet_pr_infos", "form_type", :string, :default => "review"
    QuestionSheetPrInfo.reset_column_information
    QuestionSheetPrInfo.all.each do |pr_info|
      if pr_info.personal
        form_type = "personal"
      else
        form_type = "review"
      end
      pr_info.form_type = form_type
      pr_info.save!
    end
    remove_column "pr_question_sheet_pr_infos", "personal"
    remove_column "pr_question_sheet_pr_infos", "summary"
  end

  def self.down
    add_column "pr_question_sheet_pr_infos", "personal", :boolean, :default => false
    add_column "pr_question_sheet_pr_infos", "summary", :boolean, :default => false
    QuestionSheetPrInfo.reset_column_information
    QuestionSheetPrInfo.all.each do |pr_info|
      if pr_info.form_type == "personal"
        pr_info.personal = true
      elsif pr_info.form_type == "summary"
        pr_info.summary = true
      end
      pr_info.save!
    end
    remove_column "pr_question_sheet_pr_infos", "form_type"
  end
end
