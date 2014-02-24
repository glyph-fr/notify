module Notify
  class NotificationsDigestsMailer < ActionMailer::Base
    default from: "notifications@example.com"

    def digest email
      @email = email
      @recipient = email.recipient
      @notifications = email.notifications

      subject = "Hey #{ @recipient.name }, you have " +
                "#{ @email.notifications_count } new notifications !"

      mail(to: @recipient.email, subject: subject)
    end
  end
end
