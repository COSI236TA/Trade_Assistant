class CreateRules < ActiveRecord::Migration
  def change
    create_table :rules do |t|
      t.text :property
      t.text :rel
      t.float :target
      t.text :duration
      t.text :activated
      t.integer :last_triggered
      t.belongs_to :user
      t.belongs_to :portfolio

      t.timestamps
    end
  end
end
