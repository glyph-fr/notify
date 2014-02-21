module Notify
  module Notifier
    extend ActiveSupport::Concern

    included do
      has_many :notified_notifications, -> { ordered },
        class_name: "Notify::Notification::Base", foreign_key: "author_id"
    end
  end
end