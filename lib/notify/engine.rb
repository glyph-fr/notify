require "sucker_punch"
require "kaminari"

module Notify
  class Engine < ::Rails::Engine
    isolate_namespace Notify
  end
end
