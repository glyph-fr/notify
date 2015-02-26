module Notify
  class NotificationFrequency < ActiveRecord::Base
    mattr_accessor :frequencies
    @@frequencies = [:asap, :hourly, :daily, :weekly]

    mattr_accessor :default_frequency
    @@default_frequency = :hourly

    belongs_to :notifiable, polymorphic: true

    after_initialize :set_default_frequency

    def value
      (val = read_attribute(:value)) && val.to_sym
    end

    private

    def set_default_frequency
      self.value = @@default_frequency.to_s unless value.presence
    end
  end
end
