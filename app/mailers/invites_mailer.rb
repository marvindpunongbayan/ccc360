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

      ## sometimes there is no to address, notify sender
      if !reviewer.person.email.blank?
        #original mailer
        mail(:from => review.initiator.email, 
             :to => reviewer.person.email, 
             :subject => subject,
             :body => body)
      else
        if !review.initiator.email.blank?
          #let sender know about missing email
          body_with_err = "The following message was unable to be delivered to #{reviewer.person.full_name} because the email address is missing. \n\r #{body}"
          mail(:from => review.initiator.email, 
               :to => review.initiator.email, 
               :subject => subject,
               :body => body_with_err)
        else
          ## Both emails failed
          raise "The email address is missing for #{reviewer.person.full_name}; no email has been sent."
        end
      end 
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
      if !reminder.person.email.blank?
        mail(:from => "no-reply@pr.uscm.org", 
             :to => reminder.person.email, 
             :subject => subject,
             :body => body)
      else
          raise "The email address is missing for #{reminder.person.full_name}; no email has been sent."
      end
    end
  end
end
