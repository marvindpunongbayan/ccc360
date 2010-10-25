class ReviewersController < ApplicationController
  def new
    @review = Review.find params[:review_id]
    @reviewer = @review.reviewer_wrappers.new
  end

  def create
    @review = Review.find params[:review_id]
    @reviewer = @review.reviewer_wrappers.new params[:reviewer]
    @reviewer.save
  end
end
