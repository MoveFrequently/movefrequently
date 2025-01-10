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

ActiveRecord::Schema[8.1].define(version: 2025_01_10_155718) do
  create_table "exercises", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "description"
    t.string "name"
    t.json "steps", default: [], null: false
    t.datetime "updated_at", null: false
    t.index ["created_at"], name: "index_exercises_on_created_at", order: :desc
  end

  create_table "next_exercises", force: :cascade do |t|
    t.integer "exercise_id", null: false
    t.integer "joined_by_count", default: 0
    t.datetime "next_at", null: false
    t.index ["exercise_id"], name: "index_next_exercises_on_exercise_id"
    t.index ["next_at"], name: "index_next_exercises_on_next_at", order: :desc
  end

  add_foreign_key "next_exercises", "exercises"
end
