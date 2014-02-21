module Notify
  module Jobs
    extend ActiveSupport::Autoload

    autoload :Create, "notify/jobs/create"
    autoload :Email, "notify/jobs/email"
  end
end
