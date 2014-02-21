class User < ActiveRecord::Base
  include Notify::Notifier, Notify::Notifiable
end
