# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.1].define(version: 2026_03_24_180722) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "clients", force: :cascade do |t|
    t.string "contact"
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.datetime "updated_at", null: false
  end

  create_table "invoice_line_items", force: :cascade do |t|
    t.decimal "amount", precision: 10, scale: 2
    t.datetime "created_at", null: false
    t.text "description"
    t.decimal "hours", precision: 5, scale: 2
    t.bigint "invoice_id", null: false
    t.decimal "rate", precision: 10, scale: 2
    t.bigint "time_entry_id", null: false
    t.datetime "updated_at", null: false
    t.index ["invoice_id"], name: "index_invoice_line_items_on_invoice_id"
    t.index ["time_entry_id"], name: "index_invoice_line_items_on_time_entry_id"
  end

  create_table "invoices", force: :cascade do |t|
    t.bigint "client_id", null: false
    t.datetime "created_at", null: false
    t.date "end_date"
    t.string "pdf_url"
    t.date "start_date"
    t.string "status", default: "pending"
    t.decimal "total", precision: 10, scale: 2
    t.datetime "updated_at", null: false
    t.index ["client_id"], name: "index_invoices_on_client_id"
  end

  create_table "projects", force: :cascade do |t|
    t.bigint "client_id", null: false
    t.datetime "created_at", null: false
    t.text "description"
    t.string "name", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id"], name: "index_projects_on_client_id"
  end

  create_table "rates", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "project_id"
    t.decimal "rate", precision: 10, scale: 2, null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["project_id"], name: "index_rates_on_project_id"
    t.index ["user_id"], name: "index_rates_on_user_id"
  end

  create_table "time_entries", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.date "date", null: false
    t.text "description"
    t.decimal "hours", precision: 5, scale: 2, null: false
    t.bigint "project_id", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["project_id"], name: "index_time_entries_on_project_id"
    t.index ["user_id"], name: "index_time_entries_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email", null: false
    t.string "name", null: false
    t.string "password_digest"
    t.string "role"
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "invoice_line_items", "invoices"
  add_foreign_key "invoice_line_items", "time_entries"
  add_foreign_key "invoices", "clients"
  add_foreign_key "projects", "clients"
  add_foreign_key "rates", "projects"
  add_foreign_key "rates", "users"
  add_foreign_key "time_entries", "projects"
  add_foreign_key "time_entries", "users"
end
