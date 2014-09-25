
module Notify
  class InstallGenerator < Rails::Generators::Base
    # Copied files come from templates folder
    source_root File.expand_path('../templates', __FILE__)

    # Generator desc
    desc "Notify installation generator"

    def welcome
      say "Installing notify files ..."
    end

    def copy_initializer_file
      say "Copying Notify initializer template"
      copy_file "initializer.rb", "config/initializers/notify.rb"
    end

    def copy_migrations
      say "Installing migrations, don't forget to `rake db:migrate`"
      rake "notify:install:migrations"
    end

    def copy_notifications_views
      copy_file(
        "index.html.erb",
        "app/views/notify/notifications/index.html.erb"
      )

      copy_file(
        "show.html.erb",
        "app/views/notify/notifications/show.html.erb"
      )
    end

    def copy_mailer_files
      say "Generating mailer"

      copy_file(
        "mailer.rb",
        "app/mailers/notify/notifications_mailer.rb"
      )

      # Copy mailer digest email templates
      copy_file(
        "digest_mail.text.erb",
        "app/views/notify/notifications_mailer/digest.text.erb"
      )

      copy_file(
        "digest_mail.html.erb",
        "app/views/notify/notifications_mailer/digest.html.erb"
      )

      # Copy mailer notification email templates
      copy_file(
        "notification_mail.text.erb",
        "app/views/notify/notifications_mailer/notification.text.erb"
      )

      copy_file(
        "notification_mail.html.erb",
        "app/views/notify/notifications_mailer/notification.html.erb"
      )

      # Copy mailer layouts
      copy_file(
        "mail_layout.text.erb",
        "app/views/layouts/notifications_mailer.text.erb"
      )

      copy_file(
        "mail_layout.html.erb",
        "app/views/layouts/notifications_mailer.html.erb"
      )
    end

    def copy_locale_file
      copy_file("notify.en.yml", "config/locales/notify.en.yml")
    end

    def mount_engine
      mount_path = ask(
        "Where would you like to mount the Notify engine to access and read " +
          "notifications ? [/notifications]"
      ).presence || '/notifications'

      gsub_file "config/routes.rb", /mount Notify::Engine.*\'/, ''

      path = mount_path.match(/^\//) ? mount_path : "/#{ mount_path }"
      route "mount Notify::Engine => '#{ path }', :as => 'notifications'"
    end
  end
end
