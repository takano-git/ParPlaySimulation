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

ActiveRecord::Schema.define(version: 2021_06_24_014004) do

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.integer "record_id", null: false
    t.integer "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "areas", force: :cascade do |t|
    t.string "prefecture", null: false
    t.string "district", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cards", force: :cascade do |t|
    t.integer "card_id", null: false
    t.string "customer_id", default: "", null: false
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_cards_on_user_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "clubs", force: :cascade do |t|
    t.string "yarn_count_string", default: "", null: false
    t.integer "yarn_count_number"
    t.string "detail", default: ""
    t.float "loft"
    t.float "largo", null: false
    t.integer "weight", null: false
    t.string "balance_string", default: ""
    t.float "balance_number"
    t.integer "frequency"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_clubs_on_user_id"
  end

  create_table "courses", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.integer "golfclub_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["golfclub_id"], name: "index_courses_on_golfclub_id"
  end

  create_table "golfclubs", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.string "home_page_url"
    t.string "strategy_video"
    t.integer "area_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["area_id"], name: "index_golfclubs_on_area_id"
  end

  create_table "holes", force: :cascade do |t|
    t.integer "hole_number", null: false
    t.integer "number_of_pars", null: false
    t.integer "golfclub_id"
    t.integer "course_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_holes_on_course_id"
    t.index ["golfclub_id"], name: "index_holes_on_golfclub_id"
  end

  create_table "posts", force: :cascade do |t|
    t.string "title", default: "", null: false
    t.string "comment", default: "", null: false
    t.integer "user_id"
    t.integer "golfclub_id"
    t.integer "category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_posts_on_category_id"
    t.index ["golfclub_id"], name: "index_posts_on_golfclub_id"
    t.index ["user_id"], name: "index_posts_on_user_id"
  end

  create_table "selected_clubs", force: :cascade do |t|
    t.integer "club_id", null: false
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_selected_clubs_on_user_id"
  end

  create_table "strategy_infos", force: :cascade do |t|
    t.integer "user_id"
    t.integer "golfclub_id"
    t.integer "course_id"
    t.integer "hole_id"
    t.integer "shot_id", null: false
    t.integer "location_name"
    t.text "comment"
    t.integer "photo_target_x"
    t.integer "photo_target_y"
    t.integer "photo_point_x"
    t.integer "photo_point_y"
    t.integer "photo_size_x"
    t.integer "photo_size_y"
    t.integer "map_target_x"
    t.integer "map_target_y"
    t.integer "map_point_x"
    t.integer "map_point_y"
    t.integer "map_shoot_x"
    t.integer "map_shoot_y"
    t.integer "map_size_x"
    t.integer "map_size_y"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_strategy_infos_on_course_id"
    t.index ["golfclub_id"], name: "index_strategy_infos_on_golfclub_id"
    t.index ["hole_id"], name: "index_strategy_infos_on_hole_id"
    t.index ["user_id"], name: "index_strategy_infos_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", default: "匿名さん", null: false
    t.string "nickname", default: "匿名さん", null: false
    t.string "membership_number"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "phone_number", default: "000-0000-0000", null: false
    t.integer "flying_distance"
    t.boolean "admin", default: false
    t.integer "payment_id"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "subscription_id"
    t.boolean "premium", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
