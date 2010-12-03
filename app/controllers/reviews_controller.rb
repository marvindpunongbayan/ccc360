class ReviewsController < AnswerSheetsController
  prepend_before_filter :set_answer_sheet_type
  layout :set_layout

  def index
    reviews = current_person.initiated_reviews(:include => :reviewings)
    @current_reviews = reviews.find_all{ |r| !r.past? }
    @past_reviews = reviews.find_all{ |r| r.past? }
    if session[:add_dialog]
      begin
        @review = Review.find session[:add_dialog]
        @add_dialog = session[:add_dialog]
      rescue
      ensure
        session.delete :add_dialog
      end
    end
    new if params[:start] == "true"
    set_personal_question_sheets
  end

  def send_reminders
    Review.send_all_reminders
    render :text => %|Reminders sent.  See <A HREF="http://email.int.uscm.org/">http://email.int.uscm.org</A>|
  end

  def search
    @limit = 50
    super
  end

  def new
    set_review_question_sheets
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
    unless request.xhr?
      redirect_to collate_review_path(params[:id])
    else
      @review = Review.find params[:id]
    end
  end

  def create
    new_review_params = session[:new_review].merge(params[:review])

    @review = Review.new new_review_params
    @review.due = begin Date.strptime(new_review_params["due"], (I18n.t 'date.formats.default'))
                  rescue
                    nil
                  end
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

  def destroy
    @review = Review.find params[:id]
    if @review.can_delete?(current_person)
      @review.destroy
    end
  end

  def remind_reviewers
    base_url
    @review = Review.find params[:id]
    # send email out again
    msgs = []
    (params[:reviewers] || []).each do |id, v|
      if v == "1"
        r = @review.reviewings.find id
        msgs << "#{r.person.full_name} (#{r.person.email})"
        InvitesMailer.reviewer_invite(r, "Manual Reminder").deliver
      end
    end
    if msgs.present?
      @title = "Email Reminder"
      @msg = "<strong>An email reminder has been sent out to:</strong><br/> #{msgs.join('<br/>')}"
    else
      @title = "Email Reminder"
      @msg = "Please select at least one reviewer."
    end
  end

  def edit_details
    @review = Review.find params[:id]
    unless @review.initiator == current_person || admin?
      error_and_try_back("Sorry, you don't have permission to edit this review.")
      return
    end

    @subject = @review.subject
    @initiator = @review.initiator
  end

  def update
    @review = Review.find params[:id]
    unless @review.initiator == current_person || admin?
      error_and_try_back("Sorry, you don't have permission to edit this review.")
      return
    end

    if @review.update_attributes(params[:review])
      render :update do |page|
        page.redirect_to reviews_url
      end
    else
      @subject = @review.subject
      @initiator = @review.initiator
      render :action => :edit_details
    end

  end

  protected
    def set_answer_sheet_type
      params[:answer_sheet_type] = 'Review'
    end
end
