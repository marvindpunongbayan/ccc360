class InvitesMailer < ActionMailer::Base
  def reviewer_invite(reviewer, template_name)
    email_template = EmailTemplate.find_by_name template_name
    if email_template.nil?
      raise "Email Template #{template_name} could not be found"
    else
      review = reviewer.review
      template_params = { 
        "review_name" => review.name,
        "review_url" => reviewer.url($base_url),
        "subject_name" => review.subject.full_name,
        "initiator_name" => review.initiator.full_name,
        "subject_pronoun" => review.subject.is_male? ? "his" : "her",
        "due_date" => I18n.l(review.due)
      }
      subject = Liquid::Template.parse(email_template.subject).render(template_params)
      body = Liquid::Template.parse(email_template.content).render(template_params)
      mail(:from => review.initiator.email, 
           :to => reviewer.person.email, 
           :subject => subject,
           :body => body)
    end
  end
  def manual_reminder(reminder, template_name)
    email_template = EmailTemplate.find_by_name template_name
    if email_template.nil?
      raise "Email Template #{template_name} could not be found"
    else
      template_params = { 
        "name" => reminder.person.full_name,
        "label" => reminder.label,
        "notes" => reminder.note,
        "reminder_date" => I18n.l(reminder.reminder_date)
      }
      subject = Liquid::Template.parse(email_template.subject).render(template_params)
      body = Liquid::Template.parse(email_template.content).render(template_params)
      mail(:from => "no-reply@pr.uscm.org", 
           :to => reminder.person.email, 
           :subject => subject,
           :body => body)
    end
  end
end
