require "notify"

namespace :notify do
  desc <<-DESC
    Create notifications digest e-mails for notifiables with a given choosen
    frequency.
    Usage : bundle exec rake notify:digest FREQUENCY=<frequency>
  DESC
  task digest: :environment do
    unless (frequency_value = ENV["FREQUENCY"]).presence
      raise "missing FREQUENCY argument, please add FREQUENCY=<frequency>"
    end

    Notify::MailableNotifications.new(frequency_value).email_digest
  end
end
