# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_11_06_142448) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "match_pairs", force: :cascade do |t|
    t.bigint "profile_id"
    t.bigint "match_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["match_id"], name: "index_match_pairs_on_match_id"
    t.index ["profile_id"], name: "index_match_pairs_on_profile_id"
  end

  create_table "profiles", force: :cascade do |t|
    t.string "dog_name"
    t.text "biography"
    t.bigint "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "picture"
    t.text "accepted_profiles", default: [], array: true
    t.text "rejected_profiles", default: [], array: true
    t.string "picture_url"
    t.index ["user_id"], name: "index_profiles_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "password_digest", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "match_pairs", "profiles"
end
