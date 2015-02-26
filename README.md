# Notify

This gem allows you to build a simple notification system with ActiveRecord.

It works by letting your create sub-classes of a base notification model to
handle the different notifications types you may need in your app.

To keep your app responsive, we use [Sucker Punch](https://github.com/brandonhilkert/sucker_punch)
internally to kick asynchronous jobs off that will create the actual
notifications.

## Installation

Add the following line to your Gemfile and `bundle install` :

```ruby
gem "notify", github: "vala/notify"
```

Run the install generator that will setup the initializer and
migrations :

```bash
rails generate notify:install
```

## Usage

### Notifiable and Notifiers

To allow your users to fetch their notifications, include the appropriate
modules in your user's class :

```ruby
class User
  include Notify::Notifier, Notify::Notifiable
end
```

### Creating a notification class

Now start creating your first notification type with the following generator :

```bash
rails generate notify:notification NewPublication
```

This will create a `Notify::Notification::Base` sub-class where you'll put
all your notification type's specific behavior.

```ruby
module Notify
  module Notification
    class NewPublication < Notify::Notification::Base
      def self.recipients_for resource
        resource.author.followers
      end
    end
  end
end
```

You can automatically remove the current user from the notification's recipients
list by assigning the current_user to a request-bound global store.

By doing this, the current user will never get notified of any notification
that is fired during an action he's done.

```ruby
class ApplicationController < ActionController::Base
  before_filter :store_current_user

  private

  def store_current_user
    Notify::Base.current_user = current_user

    # This internally uses the `request_store` gem, so you can alternatively
    # assign the current user to the RequestStore.store directly, if you're
    # already using the `request_store` gem in your app :
    #
    #   RequestStore.store[:current_user] = current_user
  end
end
```

### Firing notifications

You'll now be able to create notifications :

```ruby
class Publication < ActiveRecord::Base
  after_create :notify_creation

  private

  def notify_creation
    Notify.new_publication(self, author_id: writer_id)
  end
end
```

This will launch a new background job with Sucker Punch and call your class'
`::recipients_for` method to fetch the notification recipients and create
a notification for each recipient.

### Batch sending notifications by e-mail

When creating notifications, they're assigned to their recipients, and you
can fetch them, for each recipient user, read, delete them etc.

But you may want to send digest e-mails to your users, giving them the ability
to keep informed of what's happening on the app while being offline.

#### Sending pending notifications

All you have to do, is to run the provided Rake task :

```bash
rake notify:digest FREQUENCY=hourly
```

You'll want to create a jobs that runs this task every time you want to send
unread notifications digest e-mails to your users.

#### Notifications frequencies

As you may have noticed, the rake task takes a **required** `FREQUENCY`
argument. Notify allows you to let your users decide between multiple
unread notifications digest e-mailing frequencies.

By default, the 3 notifications frequencies provided are `:asap`, `:hourly` and
`:daily`. You can change them in the initializer, as well as the default one
which is automatically created when a new user is created.
Here are the defaults :

```ruby
Notify.config do |config|
  config.notification_frequency.frequencies = [:asap, :hourly, :daily, :weekly]
  config.notification_frequency.default_frequency = :hourly
end
```

What you'll need to do is to provide 3 jobs that run at certain intervals to
make it work. For example, if you have the 3 default rates active, you'll need
3 jobs, with each running the `rake notify:digest` task with the right
frequency :

```ruby
rake notify:digest FREQUENCY=asap   # Often, like every 10 minutes or less
rake notify:digest FREQUENCY=hourly # Every hour
rake notify:digest FREQUENCY=daily  # Every day
```

**Note** : If you don't care about letting your users choose their notification
frequency, you can optionnaly let the default behavior in place, and only add
one rake job to run the rake task at any interval you want, with the default
frequency name :

```ruby
rake notify:digest FREQUENCY=hourly # Run it when you want
```

## Licence

Released under the MIT-LICENSE
