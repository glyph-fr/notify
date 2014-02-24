module Notify
  class DigestEmail
    attr_accessor :recipient, :notifications

    def initialize recipient, notifications
      @recipient = recipient
      @notifications = notifications
    end

    def notifications_count
      @notifications_count ||= notifications.length
    end
  end
end
