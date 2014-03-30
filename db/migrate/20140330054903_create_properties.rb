class CreateProperties < ActiveRecord::Migration
  def change
    create_table :properties do |t|
      t.integer :p_id
      t.string :d_name
      t.string :q_name
      t.timestamps
    end
  end
end
