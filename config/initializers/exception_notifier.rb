Ccc360::Application.config.middleware.use ExceptionNotifier,
  :email_prefix => "[PR] ",
  :sender_address => %{"PR Exception Notifier" <notifier@pr.uscm.org>},
  :exception_recipients => %w{andrewroth@gmail.com}

class ExceptionInterceptor
  @@smtp_settings_before = ActionMailer::Base.smtp_settings
  @@live_smtp_settings = {
    :address   => "smtp1.ccci.org",
    :domain   => "ccci.org"
  }
 
  def self.delivering_email(mail)
    if mail.subject =~ /^\[PR\]/
      live_settings
    end
  end

  def self.delivered_email(mail)
    revert_settings
  end

  def self.live_settings
    ActionMailer::Base.smtp_settings = @@live_smtp_settings
    Rails.logger.info "before - SET smtp settings to: #{ActionMailer::Base.smtp_settings.inspect}"
  end

  def self.revert_settings
    ActionMailer::Base.smtp_settings = @@smtp_settings_before
    Rails.logger.info "after - SET smtp settings to: #{ActionMailer::Base.smtp_settings.inspect}"
  end
end

#ActionMailer::Base.register_interceptor(ExceptionInterceptor)
#ActionMailer::Base.register_observer(ExceptionInterceptor)
