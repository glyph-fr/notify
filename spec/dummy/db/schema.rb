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

ActiveRecord::Schema.define(version: 20140221173031) do

  create_table "notify_notifications", force: true do |t|
    t.integer  "resource_id"
    t.string   "resource_type"
    t.string   "type"
    t.boolean  "read",          default: false
    t.boolean  "emailed",       default: false
    t.integer  "author_id"
    t.integer  "recipient_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "notify_notifications", ["recipient_id"], name: "index_notify_notifications_on_recipient_id"
  add_index "notify_notifications", ["resource_type", "resource_id"], name: "index_notify_notifications_on_resource_type_and_resource_id"

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
