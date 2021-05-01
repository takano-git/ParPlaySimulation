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

ActiveRecord::Schema.define(version: 2021_04_26_131119) do

  create_table "areas", force: :cascade do |t|
    t.string "prefecture", null: false
    t.string "district", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "categories", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "nickname"
    t.string "membership_number"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "phone_number"
    t.integer "flying_distance"
    t.boolean "admin", default: false
    t.integer "payment_id"
    t.string "provider"
    t.string "uid"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
