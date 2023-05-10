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

ActiveRecord::Schema[7.1].define(version: 2023_02_14_165150) do
  create_table "companies", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "employees", force: :cascade do |t|
    t.string "name"
    t.string "position"
    t.string "office"
    t.integer "age"
    t.date "start_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "company_id"
    t.index ["company_id"], name: "index_employees_on_company_id"
    t.index ["name"], name: "index_employees_on_name"
  end

# Could not dump table "fts_employees" because of following StandardError
#   Unknown type '' for column 'name'

# Could not dump table "fts_employees_content" because of following StandardError
#   Unknown type '' for column 'c0name'

  create_table "fts_employees_docsize", primary_key: "docid", force: :cascade do |t|
    t.binary "size"
  end

  create_table "fts_employees_segdir", primary_key: ["level", "idx"], force: :cascade do |t|
    t.integer "level"
    t.integer "idx"
    t.integer "start_block"
    t.integer "leaves_end_block"
    t.integer "end_block"
    t.binary "root"
  end

  create_table "fts_employees_segments", primary_key: "blockid", force: :cascade do |t|
    t.binary "block"
  end

  create_table "fts_employees_stat", force: :cascade do |t|
    t.binary "value"
  end

  create_table "sales", force: :cascade do |t|
    t.integer "amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "employees", "companies"
end
