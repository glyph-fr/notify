module Notify
  class MailableNotifications
    attr_reader :frequency

    def initialize frequency
      @frequency = frequency.to_s
    end

    def send_emails
      begin
        send_digests
        send_notifications
      rescue => exception
        ExceptionNotifier.notify_exception(exception)
      end
    end

    def send_digests
      digestible_notifications = notifications.digestible

      if (digestible_notifications).length > 0
        Notify::Jobs::NotificationsDigestEmail.new(
          digestible_notifications
        ).notify
      end
    end

    def send_notifications
      notifications.not_digestible.each do |notification|
        Notify::Jobs::NotificationEmail.new(notification).notify
      end
    end

    private

    def notifications
      @notification.unread.not_emailed.reject do |notification|
        notification.resource_id.present? && notification.resource.blank?
      end.destroy_all
      
      @notifications ||= Notify::Notification::Base
        .includes(recipient: :notification_frequency)
        .where(notify_notification_frequencies: { value: frequency })
        .unread
        .not_emailed
    end
  end
end
