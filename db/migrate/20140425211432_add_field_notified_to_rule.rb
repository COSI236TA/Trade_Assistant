class AddFieldNotifiedToRule < ActiveRecord::Migration
  def change
    add_column :rules, :notified_time, :datetime
  end
end
