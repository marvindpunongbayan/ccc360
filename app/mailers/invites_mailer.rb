class InvitesMailer < ActionMailer::Base
  def reviewer_invite(reviewer)
    @review_url = reviewer.url($base_url)
    review = reviewer.review
    @subject_name = review.subject.full_name
    @initiator_name = review.initiator.full_name
    @subject_pronoun = review.subject.is_male? ? "his" : "her"
    @due_date = review.due
    mail(:from => review.initiator.email, :to => reviewer.person.email, 
         :subject => "#{review.name} for #{@subject_name}")
  end
end
