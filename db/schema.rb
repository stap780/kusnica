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

ActiveRecord::Schema.define(version: 2022_01_31_101509) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer "priority", default: 0, null: false
    t.integer "attempts", default: 0, null: false
    t.text "handler", null: false
    t.text "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string "locked_by"
    t.string "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["priority", "run_at"], name: "delayed_jobs_priority"
  end

  create_table "ebay_setups", force: :cascade do |t|
    t.string "ebay_username"
    t.string "ebay_password"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "etsy_setups", force: :cascade do |t|
    t.string "api_key"
    t.string "api_secret"
    t.string "code"
    t.string "token"
    t.string "secret"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "products", force: :cascade do |t|
    t.string "sku"
    t.string "title"
    t.string "desc"
    t.string "cat"
    t.decimal "oldprice"
    t.decimal "price"
    t.integer "quantity"
    t.string "image"
    t.string "url"
    t.string "parametr"
    t.integer "ins_id"
    t.integer "ins_var_id"
    t.bigint "ebay_id"
    t.bigint "etsy_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "price_dollar"
    t.string "title_en"
    t.string "desc_en"
    t.boolean "status_ebay"
    t.boolean "status_etsy"
    t.decimal "price_etsy"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.bigint "role_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["role_id"], name: "index_users_on_role_id"
  end

  add_foreign_key "users", "roles"
end
