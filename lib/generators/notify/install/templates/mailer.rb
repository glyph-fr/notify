module Notify
  class NotificationsMailer < ActionMailer::Base
    default from: "notifications@example.com"

    layout 'notifications_mailer'

    cattr_accessor :subject_prefix
    @@subject_prefix = nil

    def digest(email)
      @email = email
      @recipient = email.recipient
      @notifications = email.notifications

      # Generate E-mail subject from translations
      @subject = I18n.t(
        'notify.mailer.digest.subject',
        count: @email.notifications_count,
        default: 'You have unread notifications'
      )

      prefix_subject!

      mail(to: @recipient.email, subject: @subject)
    end

    def notification(email)
      @email = email
      @recipient = email.recipient
      @notification = email.notification

      # Generate E-mail subject from translations
      @subject = I18n.t(
        'notify.mailer.notification.subject',
        default: 'You have an unread notification'
      )

      prefix_subject!

      mail(to: @recipient.email, subject: @subject)
    end

    private

    def prefix_subject!
      # Add prefix to the subject if configured
      @subject = [
        self.class.subject_prefix.presence,
        @subject
      ].compact.join(" ")
    end
  end
end
