require "notify/engine"

module Notify
  extend ActiveSupport::Autoload

  autoload :Notifiable, "notify/notifiable"
  autoload :Notifier, "notify/notifier"
  autoload :Jobs, "notify/jobs"
  autoload :BatchEmail, "notify/batch_email"

  def self.table_prefix
    "notify_"
  end


  # Configuration
  #
  def self.config &block
    yield self
  end

  def self.batch_email
    Notify::BatchEmail
  end

  def self.method_missing name, *args, &block
    if model = notification_class(name.to_s)
      model.notify(*args)
    else
      super
    end
  end

  def self.notification_class name
    class_name = name.camelize

    if production?
      Notify::Notification.const_defined?(class_name) &&
        Notify::Notification.const_get(class_name)
    else
      # Fix for development env that doesn't eager load models
      # begin
        Notify::Notification.const_get(class_name)
      # rescue NameError
      # end
    end
  end

  def self.production?
    Rails.env == "production"
  end
end
