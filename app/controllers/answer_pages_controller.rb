require_dependency Rails.root.join('vendor','plugins','questionnaire_engine','app','controllers','answer_pages_controller').to_s
class AnswerPagesController < ApplicationController
  protected
  
  def get_answer_sheet
    @answer_sheet = PersonalForm.find(params[:answer_sheet_id])
    @presenter = AnswerPagesPresenter.new(self, @answer_sheet, params[:a])
  end
    
end