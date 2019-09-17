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

ActiveRecord::Schema.define(version: 2019_09_15_210900) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "owners", force: :cascade do |t|
    t.bigint "document"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "stores", force: :cascade do |t|
    t.string "name"
    t.bigint "owner_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["owner_id"], name: "index_stores_on_owner_id"
  end

  create_table "transaction_types", force: :cascade do |t|
    t.integer "type_code"
    t.string "description"
    t.integer "kind"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "transactions", force: :cascade do |t|
    t.bigint "transaction_type_id"
    t.datetime "occurrence_date"
    t.string "card"
    t.bigint "store_id"
    t.integer "value_cents", default: 0, null: false
    t.string "value_currency", default: "BRL", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["store_id"], name: "index_transactions_on_store_id"
    t.index ["transaction_type_id"], name: "index_transactions_on_transaction_type_id"
  end

  add_foreign_key "stores", "owners"
  add_foreign_key "transactions", "stores"
  add_foreign_key "transactions", "transaction_types"
end
