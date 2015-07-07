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

ActiveRecord::Schema.define(version: 20150707151834) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "ads", force: :cascade do |t|
    t.integer  "source_id",               null: false
    t.string   "uid",                     null: false
    t.integer  "status",     default: 0,  null: false
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.string   "hostname",   default: "", null: false
  end

  add_index "ads", ["hostname", "uid"], name: "index_ads_on_hostname_and_uid", unique: true, using: :btree
  add_index "ads", ["source_id"], name: "index_ads_on_source_id", using: :btree

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "jobs", force: :cascade do |t|
    t.string   "name"
    t.integer  "status",     default: 0, null: false
    t.integer  "source_id"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "jobs", ["source_id"], name: "index_jobs_on_source_id", using: :btree

  create_table "sources", force: :cascade do |t|
    t.string   "list_url",                  null: false
    t.string   "form_url",                  null: false
    t.string   "form_name",                 null: false
    t.string   "form_email",                null: false
    t.string   "form_phone", default: "",   null: false
    t.text     "form_body",                 null: false
    t.boolean  "form_cc",    default: true
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.string   "page_param", default: "o",  null: false
    t.integer  "page_start", default: 1,    null: false
    t.integer  "page_max",   default: 1,    null: false
    t.string   "title",      default: "",   null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "username",        null: false
    t.string   "password_digest", null: false
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_foreign_key "ads", "sources"
  add_foreign_key "jobs", "sources"
end
