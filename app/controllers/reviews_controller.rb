class ReviewsController < AnswerSheetsController
  prepend_before_filter :set_answer_sheet_type

  def index
    reviews = current_person.initiated_reviews(:include => :reviewings)
    @current_reviews = reviews.find_all{ |r| !r.past? }
    @past_reviews = reviews.find_all{ |r| r.past? }
    @hide_new_review = !admin? && current_person.ministry_missional_team_members.count == 0
    if session[:add_dialog]
      begin
        @review = Review.find session[:add_dialog]
        @add_dialog = session[:add_dialog]
      rescue
      ensure
        session.delete :add_dialog
      end
    end
    set_personal_question_sheets
  end

  def search
    @limit = 7
    super
  end

  def new
    @question_sheets = QuestionSheet.find_all_by_archived(false, :joins => :question_sheet_pr_info,
                                                          :conditions => [ "personal = false" ])
    session[:new_review] = {}
  end

  def new_initiator
    @subject = Person.find session[:new_review][:subject_id]
  end

  def new_details
    @subject = Person.find session[:new_review][:subject_id]
    @initiator = Person.find session[:new_review][:initiator_id]
    @review = Review.new :question_sheet_id => session[:new_review][:question_sheet_id]
  end

  def new_submit_form
    session[:new_review][:question_sheet_id] = params[:question_sheet_id]
    redirect_to new_subject_reviews_url(:format => "js")
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

  def show
    @review = Review.find params[:id]
  end

  def create
    new_review_params = session[:new_review].merge(params[:review])
    @review = Review.new new_review_params
    if @review.save
      session[:add_dialog] = @review.id
      render :update do |page|
        page.redirect_to reviews_url
      end
    else
      @subject = @review.subject
      @initiator = @review.initiator
      render :action => :new_details
    end
  end

  def remind_reviewers
    @review = Review.find params[:id]
    # send email out again
    msgs = []
    (params[:reviewers] || []).each do |id, v|
      if v == "1"
        r = @review.reviewings.find id
        msgs << "#{r.person.full_name} (#{r.person.email})"
        InvitesMailer.reviewer_invite(r).deliver
      end
    end
    if msgs.present?
      @title = "Email Reminder Sent"
      @msg = "An email reminder has been sent out to: #{msgs.join(', ')}"
    else
      @title = "Email Reminder Error"
      @msg = "Please select at least one reviewer."
    end
  end

  protected
    def set_answer_sheet_type
      params[:answer_sheet_type] = 'Review'
    end
end
