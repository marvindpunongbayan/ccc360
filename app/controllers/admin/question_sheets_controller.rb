# require_dependency "#{Rails.root}/vendor/plugins/questionnaire_engine/app/controllers/admin/question_sheets_controller.rb"

class Admin::QuestionSheetsController < ApplicationController
  include Qe::Concerns::Controllers::Admin::QuestionSheetsController
  
  before_filter :set_qe_flags

  def toggle_personal
    get_question_sheet
    @question_sheet.personal = !@question_sheet.personal
    @question_sheet.save!
  end

  # mark sheet as destroyed
  # DELETE /question_sheets/1
  def destroy
    @question_sheet.fake_deleted = true
    @question_sheet.save!
    @question_sheet.reviews.each do |review|
      review.fake_deleted = true
      review.save!
    end

    respond_to do |format|
      format.html { redirect_to admin_question_sheets_path }
      format.xml  { head :ok }
    end
  end

  protected

    def set_qe_flags
      @questionnaire = true
      @qe_admin = true
    end

    def sort_question_sheets
      @active_question_sheets.sort!{ |qs1, qs2| 
        s1 = qs1.question_sheet_pr_info.form_type <=> qs2.question_sheet_pr_info.form_type
        s2 = qs1.label <=> qs2.label
        s1 != 0 ? s1 : s2
      }
    end

end
