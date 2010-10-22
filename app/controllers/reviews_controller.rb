class ReviewsController < ApplicationController
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
  end

  def create
    @review = Review.new params[:new_review]
    if @review.save
      redirect_to dashboard_url
    else
      rener :action => :new_customize
    end
  end
end
