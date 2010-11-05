class InvitesMailer < ActionMailer::Base
  def reivewer_invite(reviewer)
    @review_url = reivewer.url($base_url)
    mail(:from => reviewer.review.initiator.email, :to => reviewer.person.email, :subject => "")
  end
end
