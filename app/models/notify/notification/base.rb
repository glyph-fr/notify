module Notify
  module Notification
    class Base < ActiveRecord::Base
      self.table_name = "notify_notifications"

      class_attribute :digestible_notification
      self.digestible_notification = true

      belongs_to :resource, polymorphic: true
      belongs_to :recipient, class_name: "User"
      belongs_to :author, class_name: "User"

      validates :type, :resource, :recipient, presence: true

      before_validation :set_digestible_state

      scope :ordered, -> { order("notify_notifications.created_at DESC") }
      scope :not_emailed, -> { where(emailed: false) }

      scope :unread, -> { where(read: false) }
      scope :read, -> { where(read: true) }

      scope :digestible, -> { where(digestible: true) }
      scope :not_digestible, -> { where.not(digestible: true) }

      def self.digest(value)
        self.digestible_notification = value
      end

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

      def self.current_user
        RequestStore.store[:current_user]
      end

      def self.current_user=(user)
        RequestStore.store[:current_user] = user
      end

      def self.recipients_excluding_current_user_for(resource)
        recipients_for(resource) - current_user
      end

      private

      def set_digestible_state
        self.digestible = self.class.digestible_notification

        # Let the validation keep going even when digestible is false
        true
      end
    end
  end
end
