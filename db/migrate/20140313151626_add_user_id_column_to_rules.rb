class AddUserIdColumnToRules < ActiveRecord::Migration
  def change
    add_column :rules, :user_id, :integer 
    add_column :rules, :last_act, :integer
  end
end
