module Notify
  module Jobs
    class NotificationEmail < Notify::Jobs::Email
      attr_accessor :notification

      def initialize notification
        @notification = notification
      end

      def notify
        email = email_for(notification.recipient, notification)
        Notify.mailer.notification(email).deliver
        notification.emailed!
      end

      private

      def email_for(recipient, notification)
        Emails::Notification.new(recipient, notification)
      end
    end
  end
end
