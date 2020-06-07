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

ActiveRecord::Schema.define(version: 2020_06_07_063901) do

  create_table "residents", force: :cascade do |t|
    t.integer "floor"
    t.integer "unit"
    t.string "name"
    t.string "ic"
    t.string "phone"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "admin", default: false
  end

  create_table "visitor_passes", force: :cascade do |t|
    t.string "resident_id"
    t.string "token"
    t.datetime "requested_at"
    t.boolean "active", default: true
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "visitors_email"
    t.string "secret_key"
    t.string "visitors_name"
  end

  create_table "visitors", force: :cascade do |t|
    t.string "name"
    t.string "ic"
    t.string "phone"
    t.string "email"
    t.string "car_no"
    t.string "secret_key"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
