require 'rails/generators/named_base'

module Notify
  class NotificationGenerator < Rails::Generators::NamedBase
    source_root File.expand_path('../templates', __FILE__)

    check_class_collision

    def copy_model
      template(
        "notification.rb",
        "app/models/notify/notification/#{ file_name }.rb"
      )
    end
  end
end