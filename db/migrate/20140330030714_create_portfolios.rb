class CreatePortfolios < ActiveRecord::Migration
  def change
    create_table :portfolios do |t|
      t.string :name
      t.text :description
      t.belongs_to :user
      t.timestamps
    end

    create_table :portfolios_stocks do |t|
      t.belongs_to :portfolios
      t.belongs_to :stocks
      t.timestamps
    end
  end
end
