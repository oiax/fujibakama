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

ActiveRecord::Schema.define(version: 20141109123934) do

  create_table "events", force: true do |t|
    t.integer  "prefecture_id", null: false
    t.string   "title",         null: false
    t.string   "venue",         null: false
    t.datetime "starts_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "events", ["prefecture_id"], name: "events_prefecture_id_fk", using: :btree
  add_index "events", ["starts_at"], name: "index_events_on_starts_at", using: :btree

  create_table "prefectures", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "schedule_items", force: true do |t|
    t.integer  "event_id",   null: false
    t.datetime "starts_at",  null: false
    t.datetime "ends_at",    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "schedule_items", ["event_id"], name: "schedule_items_event_id_fk", using: :btree

  add_foreign_key "events", "prefectures", name: "events_prefecture_id_fk"

  add_foreign_key "schedule_items", "events", name: "schedule_items_event_id_fk"

end
