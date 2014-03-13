class ReBuildRuleModel < ActiveRecord::Migration
  def change
    create_table :rules do |t|
      t.text :ticker
      t.text :property
      t.text :rel
      t.float :target
      t.text :target_type
      t.text :duration
      t.text :activated

      t.timestamps
    end
  end
end
