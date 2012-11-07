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
        "subject_name" => review.subject.informal_full_name,
        "initiator_name" => review.initiator.informal_full_name,
        "subject_pronoun" => review.subject.is_male? ? "his" : "her",
        "due_date" => I18n.l(review.due)
      }
      subject = Liquid::Template.parse(email_template.subject).render(template_params)
      body = Liquid::Template.parse(email_template.content).render(template_params)

      ## sometimes there is no to address, notify sender
      if reviewer.person.email.blank?
        if review.initiator.email.blank?
          ## Both emails failed
          raise "The email address is missing for #{reviewer.person.informal_full_name}; no email has been sent."
        else
          #let sender know about missing email
          body_with_err = "A message was unable to be delivered to #{reviewer.person.informal_full_name} because the email address is missing. \n\r"
          mail(:from => review.initiator.email, 
               :to => review.initiator.email, 
               :subject => subject,
               :body => body_with_err)
        end
      else
        #original mailer
        mail(:from => review.initiator.email, 
             :to => reviewer.person.email, 
             :subject => subject,
             :body => body)
      end
    end
  end
  def manual_reminder(reminder, template_name)
    email_template = EmailTemplate.find_by_name template_name
    if email_template.nil?
      raise "Email Template #{template_name} could not be found"
    else
      template_params = { 
        "name" => reminder.person.informal_full_name,
        "label" => reminder.label,
        "notes" => reminder.note,
        "reminder_date" => I18n.l(reminder.reminder_date)
      }
      subject = Liquid::Template.parse(email_template.subject).render(template_params)
      body = Liquid::Template.parse(email_template.content).render(template_params)
      if reminder.person.email.blank?
        raise "The email address is missing for #{reminder.person.informal_full_name}; no email has been sent."
      else
        mail(:from => "no-reply@pr.uscm.org", 
             :to => reminder.person.email, 
             :subject => subject,
             :body => body)
      end
    end
  end
end
