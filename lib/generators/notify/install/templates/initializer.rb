Notify.config do |config|
  # Configure the subject of batch notification e-mails.
  # You must assign a lambda that will be passed the recipient and the
  # notifications count to build your subject string
  #
  # config.batch_email.subject = ->(recipient, count) {
  #   "Hey #{ recipient.name }, you have #{ count } new notifications !"
  # }
end