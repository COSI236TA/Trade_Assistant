class CreateRules < ActiveRecord::Migration
  def change
    create_table :rules do |t|
      t.text :ticker
      t.text :property
      t.text :rel
      t.float :target
      t.text :duration
      t.text :activated
      t.integer :user_id
      t.integer :last_triggered

      t.timestamps
    end
  end
end
