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

    def copy_view_partial
      copy_file(
        "view_partial.html.erb",
        "app/views/notify/notifications/#{ file_name }/_notification.html.erb"
      )
    end

    def copy_mail_partial
      copy_file(
        "mail_partial.text.erb",
        "app/views/notify/notifications/#{ file_name }/_mail_item.text.erb"
      )
    end
  end
end