class CreateRules < ActiveRecord::Migration
  def change
    create_table :rules do |t|
      t.belongs_to :property
      t.string :name
      t.text :description
      t.string :rel
      t.float :target
      t.string :duration
      t.string :activated
      t.integer :last_triggered
      t.belongs_to :user
      t.belongs_to :portfolio

      t.timestamps
    end
  end
end
