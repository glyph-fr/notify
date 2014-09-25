module Notify
  module Emails
    extend ActiveSupport::Autoload

    autoload :Notification, "notify/emails/notification"
    autoload :Digest, "notify/emails/digest"
  end
end
