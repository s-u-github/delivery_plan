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

ActiveRecord::Schema.define(version: 20190727081147) do

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
    t.boolean "plan_check", default: false
    t.boolean "base_point", default: false
    t.index ["user_id"], name: "index_articles_on_user_id"
  end

  create_table "daily_reports", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "day"
    t.datetime "delivery_start"
    t.datetime "delivery_finish"
    t.string "note"
    t.integer "article_id"
    t.index ["article_id"], name: "index_daily_reports_on_article_id"
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
    t.index ["email"], name: "index_users_on_email", unique: true
  end

end
