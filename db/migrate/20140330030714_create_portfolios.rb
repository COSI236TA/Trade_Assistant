class CreatePortfolios < ActiveRecord::Migration
  def change
    create_table :portfolios do |t|
      t.string :name
      t.text :description
      t.belongs_to :user
      t.timestamps
    end

    create_table :portfolios_stocks do |t|
      t.belongs_to :portfolio
      t.belongs_to :stock
      t.timestamps
    end
  end
end
