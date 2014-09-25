module Notify
  class NotificationsDigestsMailer < ActionMailer::Base
    default from: "notifications@example.com"

    cattr_accessor :subject_prefix
    @@subject_prefix = nil

    def digest email
      @email = email
      @recipient = email.recipient
      @notifications = email.notifications

      # Generate E-mail subject from translations
      subject = I18n.t(
        'notify.mailer.digest.subject',
        count: @email.notifications_count,
        default: 'You have unread notifications'
      )

      # Add prefix to the subject if configured
      if (prefix = self.class.subject_prefix)
        subject = [prefix, subject].join(" ")
      end

      mail(to: @recipient.email, subject: subject)
    end
  end
end
