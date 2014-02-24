module Notify
  module Notifiable
    extend ActiveSupport::Concern

    included do
      has_many :notifications, -> { ordered },
        class_name: "Notify::Notification::Base", foreign_key: "recipient_id"

      has_one :notification_frequency, as: :notifiable,
        class_name: "Notify::NotificationFrequency"
      accepts_nested_attributes_for :notification_frequency,
        reject_if: :frequency_value_blank

      before_validation :ensure_notification_frequency_is_set
    end

    private

    def ensure_notification_frequency_is_set
      build_notification_frequency unless notification_frequency
    end

    def frequency_value_blank attributes
      attributes["value"].blank?
    end
  end
end