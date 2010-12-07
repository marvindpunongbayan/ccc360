Ccc360::Application.config.middleware.use ExceptionNotifier,
  :email_prefix => "[PR Exception] ",
  :sender_address => %{"PR Exception Notifier" <notifier@pr.uscm.org>},
  :exception_recipients => %w{andrewroth@gmail.com}

class ExceptionInterceptor
  def self.delivering_email(mail)
    @@smtp_settings_before = ActionMailer::Base.smtp_settings
    ActionMailer::Base.smtp_settings = {
      :address => 'localhost2',
      :port => 2525,
      :domain => 'ccci.org'
    }
    STDOUT.puts "before - SET smtp settings to: #{ActionMailer::Base.smtp_settings.inspect}"
  end
  def self.delivered_email(mail)
    revert_settings
    #STDOUT.puts "after - SET smtp settings to: #{ActionMailer::Base.smtp_settings.inspect}"
  end

  def self.revert_settings
    ActionMailer::Base.smtp_settings = @@smtp_settings_before
    STDOUT.puts "after - SET smtp settings to: #{ActionMailer::Base.smtp_settings.inspect}"
  end
end

ActionMailer::Base.register_interceptor(ExceptionInterceptor)
ActionMailer::Base.register_observer(ExceptionInterceptor)
