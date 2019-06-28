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

ActiveRecord::Schema.define(version: 20190625065717) do

  create_table "articles", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "address"
    t.float "latitude"
    t.float "longitude"
    t.string "title"
    t.string "postcode"
    t.string "phone_num"
    t.integer "user_id"
    t.integer "day_plan_id"
    t.boolean "plan_check", default: false
    t.index ["day_plan_id"], name: "index_articles_on_day_plan_id"
    t.index ["user_id"], name: "index_articles_on_user_id"
  end

  create_table "bases", force: :cascade do |t|
    t.string "base_name"
    t.integer "postcode"
    t.string "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "base_phone_num"
  end

  create_table "day_plans", force: :cascade do |t|
    t.date "date"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_day_plans_on_user_id"
  end

  create_table "deliveryinfos", force: :cascade do |t|
    t.string "guest_name"
    t.string "guest_postcode"
    t.string "guest_address"
    t.string "guest_phone_num"
    t.string "email"
    t.string "area"
    t.boolean "delivery_check", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "base_id"
    t.integer "user_id"
    t.index ["base_id"], name: "index_deliveryinfos_on_base_id"
    t.index ["user_id"], name: "index_deliveryinfos_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.string "remember_digest"
    t.boolean "admin", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "phone_num"
    t.integer "base_id"
    t.string "area"
    t.index ["base_id"], name: "index_users_on_base_id"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

end
