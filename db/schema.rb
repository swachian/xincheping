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

ActiveRecord::Schema.define(version: 20141010134355) do

  create_table "changces", force: true do |t|
    t.integer  "editor_id"
    t.datetime "c_at"
    t.string   "link"
    t.string   "title"
    t.text     "context"
    t.string   "chexin"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "changces", ["c_at"], name: "index_changces_on_c_at", using: :btree
  add_index "changces", ["chexin"], name: "index_changces_on_chexin", using: :btree
  add_index "changces", ["editor_id"], name: "index_changces_on_editor_id", using: :btree
  add_index "changces", ["link"], name: "index_changces_on_link", using: :btree

  create_table "daogoulists", force: true do |t|
    t.string   "title"
    t.string   "link"
    t.integer  "alltotalpage"
    t.integer  "zjtotalpage"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "daogous", force: true do |t|
    t.integer  "daogoulist_id"
    t.datetime "c_at"
    t.string   "title"
    t.text     "wenti"
    t.text     "zjhd"
    t.integer  "editor_id"
    t.string   "link"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "daogous", ["c_at"], name: "index_daogous_on_c_at", using: :btree
  add_index "daogous", ["daogoulist_id"], name: "index_daogous_on_daogoulist_id", using: :btree
  add_index "daogous", ["editor_id"], name: "index_daogous_on_editor_id", using: :btree

  create_table "editors", force: true do |t|
    t.string   "name"
    t.datetime "first_at"
    t.datetime "last_at"
    t.datetime "cc_first_at"
    t.datetime "cc_last_at"
    t.integer  "guandiancount",  default: 0
    t.integer  "changcecount",   default: 0
    t.datetime "pc_first_at"
    t.datetime "pc_last_at"
    t.integer  "pingcecount",    default: 0
    t.datetime "zjhd_first_at"
    t.datetime "zjhd_last_at"
    t.integer  "zjhdcount",      default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "status",         default: 0
    t.datetime "zixun_first_at"
    t.datetime "zixun_last_at"
    t.integer  "zixuncount",     default: 0
  end

  add_index "editors", ["name"], name: "index_editors_on_name", using: :btree
  add_index "editors", ["status"], name: "index_editors_on_status", using: :btree

  create_table "guandians", force: true do |t|
    t.integer  "editor_id"
    t.datetime "c_at"
    t.string   "link"
    t.string   "title"
    t.text     "context"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "guandians", ["c_at"], name: "index_guandians_on_c_at", using: :btree
  add_index "guandians", ["editor_id"], name: "index_guandians_on_editor_id", using: :btree
  add_index "guandians", ["link"], name: "index_guandians_on_link", using: :btree

  create_table "pingces", force: true do |t|
    t.integer  "editor_id"
    t.datetime "c_at"
    t.string   "title"
    t.text     "context"
    t.string   "link"
    t.integer  "clicks"
    t.string   "jielun"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "pingces", ["c_at"], name: "index_pingces_on_c_at", using: :btree
  add_index "pingces", ["clicks"], name: "index_pingces_on_clicks", using: :btree
  add_index "pingces", ["editor_id"], name: "index_pingces_on_editor_id", using: :btree
  add_index "pingces", ["jielun"], name: "index_pingces_on_jielun", using: :btree

  create_table "zixuns", force: true do |t|
    t.integer  "editor_id"
    t.datetime "c_at"
    t.string   "title"
    t.string   "link"
    t.text     "context"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "zixuns", ["c_at"], name: "index_zixuns_on_c_at", using: :btree
  add_index "zixuns", ["editor_id"], name: "index_zixuns_on_editor_id", using: :btree

end
