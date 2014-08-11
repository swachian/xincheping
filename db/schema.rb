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

ActiveRecord::Schema.define(version: 20140809063639) do

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

  add_index "changces", ["c_at"], name: "index_changces_on_c_at"
  add_index "changces", ["chexin"], name: "index_changces_on_chexin"
  add_index "changces", ["editor_id"], name: "index_changces_on_editor_id"
  add_index "changces", ["link"], name: "index_changces_on_link"

  create_table "editors", force: true do |t|
    t.string   "name"
    t.datetime "first_at"
    t.datetime "last_at"
    t.datetime "cc_first_at"
    t.datetime "cc_last_at"
    t.integer  "guandiancount", default: 0
    t.integer  "changcecount",  default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "editors", ["name"], name: "index_editors_on_name"

  create_table "guandians", force: true do |t|
    t.integer  "editor_id"
    t.datetime "c_at"
    t.string   "link"
    t.string   "title"
    t.text     "context"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "guandians", ["c_at"], name: "index_guandians_on_c_at"
  add_index "guandians", ["editor_id"], name: "index_guandians_on_editor_id"
  add_index "guandians", ["link"], name: "index_guandians_on_link"

end
