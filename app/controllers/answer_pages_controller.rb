# require_dependency Rails.root.join('vendor','plugins','questionnaire_engine','app','controllers','answer_pages_controller').to_s
require_dependency Qe::Engine.root.join('app', 'presenters', 'qe', 'answer_pages_presenter').to_s

class AnswerPagesController < ApplicationController
  protected
  
  def get_answer_sheet
    @answer_sheet = (params[:answer_sheet_type].present? ? answer_sheet_type : PersonalForm).find(params[:answer_sheet_id])
    @presenter = Qe::AnswerPagesPresenter.new(self, @answer_sheet, params[:a])
  end
    
end