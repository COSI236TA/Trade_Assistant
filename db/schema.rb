# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20140330054903) do

  create_table "portfolios", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "portfolios_stocks", force: true do |t|
    t.integer  "portfolio_id"
    t.integer  "stock_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "properties", force: true do |t|
    t.integer  "p_id"
    t.string   "d_name"
    t.string   "q_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "rule_histories", force: true do |t|
    t.integer  "rule_id"
    t.integer  "stock_id"
    t.string   "amt"
    t.datetime "triggered_time"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "rules", force: true do |t|
    t.integer  "property_id"
    t.text     "rel"
    t.float    "target"
    t.text     "duration"
    t.text     "activated"
    t.integer  "last_triggered"
    t.integer  "user_id"
    t.integer  "portfolio_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "stocks", force: true do |t|
    t.string   "ticker"
    t.string   "last_trade_price_only"
    t.string   "market_capitalization"
    t.string   "volume"
    t.string   "earnings_per_share"
    t.string   "p_e_ratio"
    t.string   "change"
    t.string   "change_in_percent"
    t.string   "day_low"
    t.string   "day_high"
    t.string   "fifty_two_week_low"
    t.string   "fifty_two_week_high"
    t.string   "change_from_52_week_low"
    t.string   "percent_change_from_52_week_low"
    t.string   "change_from_52_week_high"
    t.string   "percent_change_from_52_week_high"
    t.string   "fifty_day_moving_average"
    t.string   "change_from_50_day_moving_average"
    t.string   "percent_change_from_50_day_moving_average"
    t.string   "two_hundred_day_moving_average"
    t.string   "change_from_200_day_moving_average"
    t.string   "percent_change_from_200_day_moving_average"
    t.string   "last_trade_time"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
