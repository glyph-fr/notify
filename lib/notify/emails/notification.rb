module Notify
  module Emails
    class Notification
      attr_accessor :recipient, :notification

      def initialize recipient, notification
        @recipient = recipient
        @notification = notification
      end
    end
  end
end
