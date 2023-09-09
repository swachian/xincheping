# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_09_09_024440) do
  create_table "aaas", charset: "utf8mb3", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cantings", id: :integer, charset: "utf8mb3", force: :cascade do |t|
    t.string "title1"
    t.string "title2"
    t.string "yueshou"
    t.string "imglink"
    t.string "distance"
    t.string "timeleft"
    t.integer "isimgdownload", default: 0
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "changces", id: :integer, charset: "utf8mb3", force: :cascade do |t|
    t.integer "editor_id"
    t.timestamp "c_at"
    t.string "link"
    t.string "title"
    t.text "context"
    t.string "chexin"
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
    t.index ["c_at"], name: "index_changces_on_c_at"
    t.index ["chexin"], name: "index_changces_on_chexin"
    t.index ["editor_id"], name: "index_changces_on_editor_id"
    t.index ["link"], name: "index_changces_on_link"
  end

  create_table "daogoulists", id: :integer, charset: "utf8mb3", force: :cascade do |t|
    t.string "title"
    t.string "link"
    t.integer "alltotalpage"
    t.integer "zjtotalpage"
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
  end

  create_table "daogous", id: :integer, charset: "utf8mb3", force: :cascade do |t|
    t.integer "daogoulist_id"
    t.timestamp "c_at"
    t.string "title"
    t.text "wenti"
    t.text "zjhd"
    t.integer "editor_id"
    t.string "link"
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
    t.index ["c_at"], name: "index_daogous_on_c_at"
    t.index ["daogoulist_id"], name: "index_daogous_on_daogoulist_id"
    t.index ["editor_id"], name: "index_daogous_on_editor_id"
  end

  create_table "editors", id: :integer, charset: "utf8mb3", force: :cascade do |t|
    t.string "name"
    t.timestamp "first_at"
    t.timestamp "last_at"
    t.timestamp "cc_first_at"
    t.timestamp "cc_last_at"
    t.integer "guandiancount", default: 0
    t.integer "changcecount", default: 0
    t.timestamp "pc_first_at"
    t.timestamp "pc_last_at"
    t.integer "pingcecount", default: 0
    t.timestamp "zjhd_first_at"
    t.timestamp "zjhd_last_at"
    t.integer "zjhdcount", default: 0
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
    t.integer "status", default: 0
    t.timestamp "zixun_first_at"
    t.timestamp "zixun_last_at"
    t.integer "zixuncount", default: 0
    t.index ["name"], name: "index_editors_on_name"
    t.index ["status"], name: "index_editors_on_status"
  end

  create_table "electronic_police2s", id: :integer, charset: "utf8mb3", force: :cascade do |t|
    t.string "position"
    t.string "wddm"
    t.string "gps"
    t.string "cjsj"
    t.string "gxsj"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["position"], name: "index_electronic_police2s_on_position"
  end

  create_table "electronic_polices", id: :integer, charset: "utf8mb3", force: :cascade do |t|
    t.string "position"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["position"], name: "index_electronic_polices_on_position"
  end

  create_table "fiveks", id: :integer, charset: "utf8mb3", force: :cascade do |t|
    t.string "t1"
    t.string "cont"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "guandians", id: :integer, charset: "utf8mb3", force: :cascade do |t|
    t.integer "editor_id"
    t.timestamp "c_at"
    t.string "link"
    t.string "title"
    t.text "context"
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
    t.index ["c_at"], name: "index_guandians_on_c_at"
    t.index ["editor_id"], name: "index_guandians_on_editor_id"
    t.index ["link"], name: "index_guandians_on_link"
  end

  create_table "pingces", id: :integer, charset: "utf8mb3", force: :cascade do |t|
    t.integer "editor_id"
    t.timestamp "c_at"
    t.string "title"
    t.text "context"
    t.string "link"
    t.integer "clicks"
    t.string "jielun"
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
    t.index ["c_at"], name: "index_pingces_on_c_at"
    t.index ["clicks"], name: "index_pingces_on_clicks"
    t.index ["editor_id"], name: "index_pingces_on_editor_id"
    t.index ["jielun"], name: "index_pingces_on_jielun"
  end

  create_table "zixuns", id: :integer, charset: "utf8mb3", force: :cascade do |t|
    t.integer "editor_id"
    t.timestamp "c_at"
    t.string "title"
    t.string "link"
    t.text "context"
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
    t.index ["c_at"], name: "index_zixuns_on_c_at"
    t.index ["editor_id"], name: "index_zixuns_on_editor_id"
  end

end
