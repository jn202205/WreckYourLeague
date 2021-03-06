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

ActiveRecord::Schema.define(version: 20150507052559) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "games", force: :cascade do |t|
    t.integer  "sport_id",                      null: false
    t.integer  "user_id",                       null: false
    t.datetime "game_datetime",                 null: false
    t.float    "lat",                           null: false
    t.float    "lng",                           null: false
    t.text     "details"
    t.boolean  "complete",      default: false, null: false
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.string   "address"
  end

  add_index "games", ["game_datetime"], name: "index_games_on_game_datetime", using: :btree
  add_index "games", ["lat", "lng"], name: "index_games_on_lat_and_lng", using: :btree
  add_index "games", ["sport_id"], name: "index_games_on_sport_id", using: :btree
  add_index "games", ["user_id"], name: "index_games_on_user_id", using: :btree

  create_table "matches", force: :cascade do |t|
    t.integer  "player_id",  null: false
    t.integer  "game_id",    null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "matches", ["game_id", "player_id"], name: "index_on_game_id_and_player_id", unique: true, using: :btree

  create_table "player_sports", force: :cascade do |t|
    t.integer  "player_id",  null: false
    t.integer  "sport_id",   null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "player_sports", ["player_id", "sport_id"], name: "index_on_player_id_and_sport_id", unique: true, using: :btree
  add_index "player_sports", ["player_id"], name: "index_player_sports_on_player_id", using: :btree
  add_index "player_sports", ["sport_id"], name: "index_player_sports_on_sport_id", using: :btree

  create_table "positions", force: :cascade do |t|
    t.string   "title",      null: false
    t.integer  "sport_id",   null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "positions", ["sport_id"], name: "index_positions_on_sport_id", using: :btree
  add_index "positions", ["title"], name: "index_positions_on_title", using: :btree

  create_table "sports", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "sports", ["name"], name: "index_sports_on_name", unique: true, using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "fname",           limit: 50,                 null: false
    t.string   "lname",           limit: 50,                 null: false
    t.string   "email",                                      null: false
    t.string   "zipcode",         limit: 5,                  null: false
    t.string   "password_digest",                            null: false
    t.string   "session_token",                              null: false
    t.integer  "captain_id"
    t.integer  "player_id"
    t.boolean  "elite",                      default: false, null: false
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.string   "img_url"
    t.string   "playing_area"
    t.text     "experience"
  end

  add_index "users", ["captain_id"], name: "index_users_on_captain_id", using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["password_digest"], name: "index_users_on_password_digest", using: :btree
  add_index "users", ["player_id"], name: "index_users_on_player_id", using: :btree
  add_index "users", ["session_token"], name: "index_users_on_session_token", unique: true, using: :btree
  add_index "users", ["zipcode"], name: "index_users_on_zipcode", using: :btree

  add_foreign_key "positions", "sports"
end
