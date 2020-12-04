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

ActiveRecord::Schema.define(version: 2020_12_04_002828) do

  create_table "dislikes", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "disliked_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "disliked_id"], name: "index_dislikes_on_user_id_and_disliked_id", unique: true
  end

  create_table "likes", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "liked_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "liked_id"], name: "index_likes_on_user_id_and_liked_id", unique: true
  end

  create_table "matches", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "matched_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "matched_id"], name: "index_matches_on_user_id_and_matched_id", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "username", null: false
    t.string "password_digest", null: false
    t.text "queue"
    t.string "name", null: false
    t.date "dob", null: false
    t.integer "gender", null: false
    t.text "bio"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["username"], name: "index_users_on_username", unique: true
  end

end
