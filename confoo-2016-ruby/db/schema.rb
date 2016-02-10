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

ActiveRecord::Schema.define(version: 20160203023021) do

  create_table "comments", force: :cascade do |t|
    t.integer  "post_id",    limit: 4,     null: false
    t.integer  "user_id",    limit: 4,     null: false
    t.text     "body",       limit: 65535, null: false
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "jobs", force: :cascade do |t|
    t.string  "queue",        limit: 255,        null: false
    t.text    "payload",      limit: 4294967295, null: false
    t.integer "attempts",     limit: 1,          null: false
    t.integer "reserved",     limit: 1,          null: false
    t.integer "reserved_at",  limit: 4
    t.integer "available_at", limit: 4,          null: false
    t.integer "created_at",   limit: 4,          null: false
  end

  add_index "jobs", ["queue", "reserved", "reserved_at"], name: "jobs_queue_reserved_reserved_at_index", using: :btree

  create_table "migrations", id: false, force: :cascade do |t|
    t.string  "migration", limit: 255, null: false
    t.integer "batch",     limit: 4,   null: false
  end

  create_table "password_resets", id: false, force: :cascade do |t|
    t.string   "email",      limit: 255, null: false
    t.string   "token",      limit: 255, null: false
    t.datetime "created_at",             null: false
  end

  add_index "password_resets", ["email"], name: "password_resets_email_index", using: :btree
  add_index "password_resets", ["token"], name: "password_resets_token_index", using: :btree

  create_table "posts", force: :cascade do |t|
    t.integer  "user_id",    limit: 4,        null: false
    t.string   "slug",       limit: 255,      null: false
    t.string   "title",      limit: 255,      null: false
    t.text     "body",       limit: 16777215, null: false
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "tags", force: :cascade do |t|
    t.integer  "post_id",    limit: 4,   null: false
    t.string   "name",       limit: 255, null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name",       limit: 255, null: false
    t.string   "email",      limit: 255, null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "users", ["email"], name: "users_email_unique", unique: true, using: :btree

end
