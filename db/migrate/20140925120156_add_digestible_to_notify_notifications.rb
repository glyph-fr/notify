class AddDigestibleToNotifyNotifications < ActiveRecord::Migration
  def change
    add_column :notify_notifications, :digestible, :boolean
  end
end
