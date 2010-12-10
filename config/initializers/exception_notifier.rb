Ccc360::Application.config.middleware.use ExceptionNotifier,
  :email_prefix => "[PR] ",
  :sender_address => %{"PR Exception Notifier" <notifier@pr.uscm.org>},
  :exception_recipients => %w{andrewroth@gmail.com josh.starcher@gmail.com}
