module Notify
  module Notification
    class Base < ActiveRecord::Base
      self.table_name = "notify_notifications"

      validates :type, :resource, :recipient, presence: true

      belongs_to :resource, polymorphic: true
      belongs_to :recipient, class_name: "User"
      belongs_to :author, class_name: "User"

      scope :ordered, -> { order("notify_notifications.created_at DESC") }
      scope :unread, -> { where(read: false) }
      scope :read, -> { where(read: true) }
      scope :not_emailed, -> { where(emailed: false) }

      def read!
        update_attributes!(read: true)
      end

      def emailed!
        update_attributes!(emailed: true)
      end

      def partial_key
        @partial_key ||= self.class.name.demodulize.underscore
      end

      def summary
        I18n.t(
          'notify.notification.summary',
          type: self.class.model_name.human
        )
      end

      def self.notify(res, attributes)
        attributes.merge!(resource_type: res.class.name, resource_id: res.id)
        Notify::Jobs::Create.new.async.perform(self, attributes)
      end
    end
  end
end
