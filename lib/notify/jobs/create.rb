module Notify
  module Jobs
    class Create
      include SuckerPunch::Job

      attr_reader :model, :attributes, :current_user

      def perform(model, attributes, current_user)
        @model = model
        @attributes = attributes
        @current_user = current_user

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

      # Get recipients for a given resource, and exclude current_user if set
      def recipients
        model.recipients_for(resource) - [current_user]
      end

      def notify(recipient)
        model.create!(attributes.merge(recipient: recipient))
      end
    end
  end
end
