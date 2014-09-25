module Notify
  module Notification
    class <%= class_name %> < Notify::Notification::Base
      digest <%= digestible?.to_s %>

      def self.recipients_for(resource)
        # Fetch recipients from resource and return an Enumerable object
        []
      end
    end
  end
end
