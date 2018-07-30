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

ActiveRecord::Schema.define(version: 2018_07_30_010947) do

  create_table "beer_volumes", force: :cascade do |t|
    t.integer "beer_id"
    t.integer "volume_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["beer_id"], name: "index_beer_volumes_on_beer_id"
    t.index ["volume_id"], name: "index_beer_volumes_on_volume_id"
  end

  create_table "beers", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.datetime "fabrication"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "creators", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "beer_id"
    t.index ["beer_id"], name: "index_creators_on_beer_id"
  end

  create_table "tips", force: :cascade do |t|
    t.string "description"
    t.integer "beer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["beer_id"], name: "index_tips_on_beer_id"
  end

  create_table "volumes", force: :cascade do |t|
    t.integer "value"
    t.string "unit"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
