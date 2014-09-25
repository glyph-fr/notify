require "sucker_punch"
require "kaminari"

require "notify/engine"

module Notify
  extend ActiveSupport::Autoload

  autoload :Notifiable, "notify/notifiable"
  autoload :Notifier, "notify/notifier"
  autoload :Jobs, "notify/jobs"
  autoload :DigestEmail, "notify/digest_email"
  autoload :MailableNotifications, "notify/mailable_notifications"

  def self.table_prefix
    "notify_"
  end

  # ----------- Configuration -----------

  # The mailer used to send notification digests
  mattr_accessor :mailer_class
  @@mailer_class = "Notify::NotificationsDigestsMailer"

  def self.mailer
    @@mailer ||= @@mailer_class.constantize
  end

  mattr_accessor :notifiable_controller_method
  @@notifiable_controller_method = :current_user

  def self.config &block
    yield self
  end

  def self.digest_email
    Notify::DigestEmail
  end

  def self.notification_frequency
    Notify::NotificationFrequency
  end

  def self.method_missing name, *args, &block
    if model = notification_class(name.to_s)
      model.notify(*args)
    else
      super
    end
  end

  def self.respond_to_missing?(method, *)
    !!notification_class(method)
  end

  def self.notification_class name
    class_name = name.camelize

    if production?
      Notify::Notification.const_defined?(class_name) &&
        Notify::Notification.const_get(class_name)
    else # Fix for development env that doesn't eager load models
      begin
        Notify::Notification.const_get(class_name)
      rescue NameError
      end
    end
  end

  def self.production?
    Rails.env == "production"
  end
end
