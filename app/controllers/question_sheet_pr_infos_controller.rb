class QuestionSheetPrInfosController < ApplicationController
  def edit
    @question_sheet_pr_info = QuestionSheetPrInfo.find params[:id]
  end

  def update
    @question_sheet_pr_info = QuestionSheetPrInfo.find params[:id]
    @question_sheet_pr_info.update_attributes(params[:question_sheet_pr_info])
  end
end
