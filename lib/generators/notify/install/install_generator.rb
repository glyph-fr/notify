
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
  end
end
