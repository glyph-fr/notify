# This migration comes from notify (originally 20140221165751)
class CreateNotifyNotifications < ActiveRecord::Migration
  def change
    create_table :notify_notifications, :force => true do |t|
      t.integer  :resource_id
      t.string   :resource_type
      t.string   :type
      t.boolean  :read, default: false
      t.boolean  :emailed, default: false
      t.integer  :author_id
      t.integer  :recipient_id

      t.timestamps
    end

    add_index :notify_notifications, [:resource_type, :resource_id]
    add_index :notify_notifications, [:recipient_id]
  end
end
