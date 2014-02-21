module Notify
  module Notification
    class Base < ActiveRecord::Base
      self.table_name = "notify_notifications"

      validates_presence_of :type, :resource_id, :resource_type, :recipient_id,
        :author_id

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

      def self.notify res, attributes
        attributes.merge!(resource_type: res.class.name, resource_id: res.id)
        Notify::Jobs::Create.new.async.perform(self, attributes)
      end
    end
  end
end
