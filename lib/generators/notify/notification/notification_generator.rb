require 'rails/generators/named_base'

module Notify
  class NotificationGenerator < Rails::Generators::NamedBase
    source_root File.expand_path('../templates', __FILE__)

    check_class_collision

    argument :digest, default: 'true'

    def copy_model
      template(
        "notification.rb",
        "app/models/notify/notification/#{ file_name }.rb"
      )
    end

    def digestible?
      digest != 'false'
    end
  end
end