class ReviewsController < ApplicationController
  def index
    @reviews = current_person.initiated_reviews
  end

  def new_submit_person
    session[:new_review] ||= {}
    session[:new_review][:subject_id] = params[:person_id]
    redirect_to new_requester_reviews_url
  end

  def new_submit_requester
    redirect_to(new_reviews_url) unless session[:new_review] && session[:new_review][:subject_id]
    session[:new_review] ||= {}
    session[:new_review][:initiator_id] = params[:person_id]
    redirect_to new_customize_reviews_url
  end

  def new_customize
    @review = Review.new session[:new_review]
  end

  def show
    @review = Review.find params[:id]
  end

  def create
    # map the person_id and subject_id from person_ids to pr_users
    @review = Review.new params[:review]
    if @review.save
      redirect_to dashboard_url
    else
      rener :action => :new_customize
    end
  end
end
