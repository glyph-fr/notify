class CreateNotifyNotificationFrequencies < ActiveRecord::Migration
  def change
    create_table :notify_notification_frequencies do |t|
      t.string :value
      t.references :notifiable, polymorphic: true

      t.timestamps
    end

    add_index :notify_notification_frequencies, :value
  end
end
