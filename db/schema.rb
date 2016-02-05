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

ActiveRecord::Schema.define(version: 20151225023431) do

  create_table "cantings", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.string   "title1"
    t.string   "title2"
    t.string   "yueshou"
    t.string   "imglink"
    t.string   "distance"
    t.string   "timeleft"
    t.integer  "isimgdownload", default: 0
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "changces", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.integer  "editor_id"
    t.datetime "c_at"
    t.string   "link"
    t.string   "title"
    t.text     "context",    limit: 65535
    t.string   "chexin"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["c_at"], name: "index_changces_on_c_at", using: :btree
    t.index ["chexin"], name: "index_changces_on_chexin", using: :btree
    t.index ["editor_id"], name: "index_changces_on_editor_id", using: :btree
    t.index ["link"], name: "index_changces_on_link", using: :btree
  end

  create_table "daogoulists", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.string   "title"
    t.string   "link"
    t.integer  "alltotalpage"
    t.integer  "zjtotalpage"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "daogous", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.integer  "daogoulist_id"
    t.datetime "c_at"
    t.string   "title"
    t.text     "wenti",         limit: 65535
    t.text     "zjhd",          limit: 65535
    t.integer  "editor_id"
    t.string   "link"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["c_at"], name: "index_daogous_on_c_at", using: :btree
    t.index ["daogoulist_id"], name: "index_daogous_on_daogoulist_id", using: :btree
    t.index ["editor_id"], name: "index_daogous_on_editor_id", using: :btree
  end

  create_table "editors", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
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
    t.index ["name"], name: "index_editors_on_name", using: :btree
    t.index ["status"], name: "index_editors_on_status", using: :btree
  end

  create_table "electronic_police2s", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.string   "position"
    t.string   "wddm"
    t.string   "gps"
    t.string   "cjsj"
    t.string   "gxsj"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["position"], name: "index_electronic_police2s_on_position", using: :btree
  end

  create_table "electronic_polices", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.string   "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["position"], name: "index_electronic_polices_on_position", using: :btree
  end

  create_table "fiveks", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.string   "t1"
    t.string   "cont"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "guandians", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.integer  "editor_id"
    t.datetime "c_at"
    t.string   "link"
    t.string   "title"
    t.text     "context",    limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["c_at"], name: "index_guandians_on_c_at", using: :btree
    t.index ["editor_id"], name: "index_guandians_on_editor_id", using: :btree
    t.index ["link"], name: "index_guandians_on_link", using: :btree
  end

  create_table "pingces", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.integer  "editor_id"
    t.datetime "c_at"
    t.string   "title"
    t.text     "context",    limit: 65535
    t.string   "link"
    t.integer  "clicks"
    t.string   "jielun"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["c_at"], name: "index_pingces_on_c_at", using: :btree
    t.index ["clicks"], name: "index_pingces_on_clicks", using: :btree
    t.index ["editor_id"], name: "index_pingces_on_editor_id", using: :btree
    t.index ["jielun"], name: "index_pingces_on_jielun", using: :btree
  end

  create_table "zixuns", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.integer  "editor_id"
    t.datetime "c_at"
    t.string   "title"
    t.string   "link"
    t.text     "context",    limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["c_at"], name: "index_zixuns_on_c_at", using: :btree
    t.index ["editor_id"], name: "index_zixuns_on_editor_id", using: :btree
  end

end
