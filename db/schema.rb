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

ActiveRecord::Schema.define(version: 2020_04_02_182827) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "assets", force: :cascade do |t|
    t.string "title"
    t.integer "sequence_number", default: 1
    t.bigint "content_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["content_id"], name: "index_assets_on_content_id"
  end

  create_table "contents", force: :cascade do |t|
    t.string "title"
    t.string "type"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "purchases", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "content_id"
    t.bigint "variant_id"
    t.datetime "expires_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["content_id"], name: "index_purchases_on_content_id"
    t.index ["user_id"], name: "index_purchases_on_user_id"
    t.index ["variant_id"], name: "index_purchases_on_variant_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "provider", default: "email", null: false
    t.string "uid", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.boolean "allow_password_change", default: false
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.string "name"
    t.string "email"
    t.string "token"
    t.text "tokens"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true
  end

  create_table "variants", force: :cascade do |t|
    t.string "quality"
    t.float "price"
    t.bigint "content_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["content_id"], name: "index_variants_on_content_id"
  end

  add_foreign_key "assets", "contents"
  add_foreign_key "purchases", "contents"
  add_foreign_key "purchases", "users"
  add_foreign_key "variants", "contents"
end
