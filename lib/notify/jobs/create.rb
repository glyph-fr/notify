module Notify
  module Jobs
    class Create
      include SuckerPunch::Job

      attr_reader :model, :attributes

      def perform model, attributes
        @model = model
        @attributes = attributes

        ActiveRecord::Base.connection_pool.with_connection do
          recipients.each do |recipient|
            notify(recipient)
          end
        end
      end

      private

      def resource
        @resource ||= begin
          resource_class = attributes[:resource_type].constantize
          resource_class.find(attributes[:resource_id])
        end
      end

      def recipients
        model.recipients_for(resource)
      end

      def notify recipient
        model.create!(attributes.merge(recipient: recipient))
      end
    end
  end
end
