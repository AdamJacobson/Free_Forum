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

ActiveRecord::Schema.define(version: 20140922221403) do

  create_table "boards", force: true do |t|
    t.string   "title"
    t.string   "description"
    t.integer  "parent_board_id"
    t.boolean  "locked"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "required_rank"
  end

  create_table "moderator_joins", force: true do |t|
    t.integer  "user_id"
    t.integer  "board_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "moderator_joins", ["board_id"], name: "index_moderator_joins_on_board_id"
  add_index "moderator_joins", ["user_id"], name: "index_moderator_joins_on_user_id"

  create_table "posts", force: true do |t|
    t.integer  "user_id"
    t.integer  "topic_id"
    t.text     "content",    limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ranks", force: true do |t|
    t.string   "title"
    t.string   "color"
    t.integer  "requirement"
    t.boolean  "system",      default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "topics", force: true do |t|
    t.string   "title"
    t.integer  "user_id"
    t.integer  "board_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "last_replied_to_at"
    t.boolean  "sticky",             default: false
    t.boolean  "locked",             default: false
  end

  create_table "users", force: true do |t|
    t.string   "username"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
    t.boolean  "admin",           default: false
    t.integer  "rank_id"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["username"], name: "index_users_on_username", unique: true

end
