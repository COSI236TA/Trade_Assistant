class AddNotificationToUsers < ActiveRecord::Migration
  def change
    add_column :users, :notification, :string
  end
end
