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

...

## Licence

Released under the MIT-LICENSE
