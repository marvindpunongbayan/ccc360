desc "Sends out all reminders"
task :reminders => :environment do
  Review.send_all_reminders
end
