class ReviewersController < ApplicationController
  before_filter :get_review

  def new
    @reviewer = @review.reviewer_wrappers.new
  end

  def create
    @reviewer = @review.reviewer_wrappers.new params[:reviewer]
    @reviewer.save
  end

  def search
    @limit = 7
    super
  end

  protected

    def get_review
      @review = Review.find params[:review_id]
    end
end
