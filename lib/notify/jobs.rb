module Notify
  module Jobs
    extend ActiveSupport::Autoload

    autoload :Create, "notify/jobs/create"
    autoload :Email, "notify/jobs/email"
    autoload :NotificationEmail, "notify/jobs/notification_email"
    autoload :NotificationsDigestEmail, "notify/jobs/notifications_digest_email"
  end
end
