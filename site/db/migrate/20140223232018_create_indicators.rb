class CreateIndicators < ActiveRecord::Migration
  def change
    create_table :indicators do |t|
      t.string :name
      t.string :query_parameter

      t.timestamps
    end
  end
end
