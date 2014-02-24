module Notify
  module Jobs
    class Email
      attr_accessor :notifications

      def initialize notifications
        @notifications = notifications
      end

      def notify
        recipient_notifications.each do |recipient, notifications|
          notify_recipient(recipient, notifications)
        end
      end

      private

      def recipient_notifications
        notifications.group_by(&:recipient)
      end

      def notify_recipient recipient, notifications
        email = email_for(recipient, notifications)
        Notify.mailer.digest(email).deliver
        notifications.each(&:emailed!)
      end

      def email_for recipient, notifications
        DigestEmail.new(recipient, notifications)
      end
    end
  end
end
