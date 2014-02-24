module Notify
  class MailableNotifications
    attr_reader :frequency

    def initialize frequency
      @frequency = frequency.to_s
    end

    def email_digest
      Notify::Jobs::Email.new(notifications).notify if notifications.length > 0
    end

    private

    def notifications
      @notifications ||= Notify::Notification::Base
        .includes(recipient: :notification_frequency)
        .where(notify_notification_frequencies: { value: frequency })
        .unread
        .not_emailed
    end
  end
end