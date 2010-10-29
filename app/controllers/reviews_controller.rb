class ReviewsController < ApplicationController
  def index
    @reviews = current_person.initiated_reviews
    if session[:add_dialog]
      begin
        @review = Review.find session[:add_dialog]
        @add_dialog = session[:add_dialog]
      rescue
      ensure
        session.delete :add_dialog
      end
    end
  end

  def new
    @question_sheets = QuestionSheet.find_all_by_archived(false, :joins => :question_sheet_pr_info,
                                                          :conditions => [ "personal = false" ])
    session[:new_review] = {}
  end

  def new_requester
    @subject = Person.find session[:new_review][:subject_id]
  end

  def new_details
    @subject = Person.find session[:new_review][:subject_id]
    @initiator = Person.find session[:new_review][:initiator_id]
  end

  def new_submit_form
    session[:new_review][:question_sheet_id] = params[:question_sheet_id]
    redirect_to new_person_reviews_url(:format => "js")
  end

  def new_submit_subject
    session[:new_review][:subject_id] = params[:subject_id]
    redirect_to new_initiator_reviews_url(:format => "js")
  end

  def new_submit_initiator
    session[:new_review] ||= {}
    session[:new_review][:initiator_id] = params[:initiator_id]
    redirect_to new_details_reviews_url(:format => "js")
  end

  def new_details
    @review = Review.new session[:new_review]
  end

  def show
    @review = Review.find params[:id]
  end

  def create
    @review = Review.new params[:new_review]
    if @review.save
      session[:add_dialog] = @review.id
      redirect_to reviews_url
    else
      render :action => :new_customize
    end
  end
end
