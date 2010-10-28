class ReviewsController < ApplicationController
  def index
    @reviews = current_person.initiated_reviews
    @add_dialog = session[:add_dialog]
    if session[:add_dialog]
      @review = Review.find session[:add_dialog]
      session.delete :add_dialog
    end
  end

  def new
    @question_sheets = QuestionSheet.find_all_by_archived(false, :joins => :question_sheet_pr_info,
                                                          :conditions => [ "personal = false" ])
    session[:new_review] = {}
  end

  def new_submit_form
    session[:new_review][:form_id] = params[:question_sheet_id]
    redirect_to new_person_reviews_url(:format => "js")
  end

  def new_submit_person
    session[:new_review][:subject_id] = params[:person_id]
    redirect_to new_requester_reviews_url(:format => "js")
  end

  def new_submit_requester
    redirect_to(new_reviews_url) unless session[:new_review] && session[:new_review][:subject_id]
    session[:new_review] ||= {}
    session[:new_review][:initiator_id] = params[:person_id]
    redirect_to new_customize_reviews_url
  end

  def new_details
    @review = Review.new session[:new_review]
  end

  def show
    @review = Review.find params[:id]
  end

  def create
    # map the person_id and subject_id from person_ids to pr_users
    @review = Review.new params[:review]
    if @review.save
      session[:add_dialog] = @review.id
      redirect_to reviews_url
    else
      render :action => :new_customize
    end
  end
end
