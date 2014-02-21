module Notify
  class BatchEmail
    mattr_accessor :subject
    @@subject = ->(recipient, count) { "You have #{ count } new notifications" }

    attr_accessor :recipient, :notifications

    def initialize recipient, notifications
      @recipient = recipient
      @notifications = notifications
    end

    def subject
      @subject ||= @@subject.call(recipient, notifications_count)
    end

    def notifications_count
      @notifications_count ||= notifications.length
    end

    def recipient_email
      recipient.email
    end
  end
end
