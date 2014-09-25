module Notify
  module Notification
    class <%= class_name %> < Notify::Notification::Base
      def self.recipients_for(resource)
        # Fetch recipients from resource and return an object that responds to
        # `#each` - an Enumerable for example
        []
      end
    end
  end
end
