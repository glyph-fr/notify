require "sucker_punch"

module Notify
  class Engine < ::Rails::Engine
    isolate_namespace Notify
  end
end
