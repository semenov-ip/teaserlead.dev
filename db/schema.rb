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

ActiveRecord::Schema.define(version: 20130708021240) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "advertisement_campaigns", force: true do |t|
    t.string   "name"
    t.string   "url"
    t.integer  "category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "advertisement_campaigns", ["category_id"], name: "index_advertisement_campaigns_on_category_id", using: :btree

  create_table "categories", force: true do |t|
    t.string   "name"
    t.string   "ancestry"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "categories", ["ancestry"], name: "index_categories_on_ancestry", using: :btree

  create_table "sites", force: true do |t|
    t.integer  "category_id"
    t.string   "title",       null: false
    t.string   "url",         null: false
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sites", ["category_id"], name: "index_sites_on_category_id", using: :btree

  create_table "teaser_blocks", force: true do |t|
    t.string   "topic"
    t.string   "text_color"
    t.string   "text_encoding"
    t.string   "text_position"
    t.string   "font"
    t.integer  "block_size"
    t.string   "block_bg_color"
    t.string   "block_border_color"
    t.integer  "block_margin"
    t.string   "block_position"
    t.integer  "teaser_count"
    t.integer  "site_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "teasers", force: true do |t|
    t.string   "text",                                   null: false
    t.string   "image",                                  null: false
    t.string   "url",                       default: "", null: false
    t.integer  "advertisement_campaign_id",              null: false
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email"
    t.string   "password_digest"
    t.string   "roles",           default: "---\n- :user\n",      null: false
    t.datetime "last_sign_in_at", default: '1970-01-01 00:00:00', null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
