Notify.config do |config|
  # Configure the different notification digest e-mails frequencies available
  # to notifiable users.
  #
  # The below frequencies are the default ones
  #
  # config.notification_frequency.frequencies = [:asap, :hourly, :daily]

  # Set the default frequency assigned to notifiable users that didn't choose
  # a frequency themselves.
  # Useful when notifications digest e-mails frequency is not set on sign up.
  #
  # Defaults to :hourly
  #
  # config.notification_frequency.default_frequency = :hourly

  # Set the method used in the Notify controller to fetch the current notifiable
  # object from which to show and read notifications
  #
  # Defaults to Devise-like `current_user` method
  #
  # config.notifiable_controller_method = :current_user

  # Configure the mailer used to send notifications
  #
  # Defaults to the mailer class that is generated during installation
  #
  # config.mailer_class = "Notify::NotificationsMailer"
end