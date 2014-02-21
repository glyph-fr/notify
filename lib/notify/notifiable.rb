module Notify
  module Notifiable
    extend ActiveSupport::Concern

    included do
      has_many :received_notifications, -> { ordered },
        class_name: "Notify::Notification::Base", foreign_key: "recipient_id"
    end
  end
end