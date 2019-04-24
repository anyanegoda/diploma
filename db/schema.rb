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

ActiveRecord::Schema.define(version: 2019_04_23_090343) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "educational_and_methodical_works", force: :cascade do |t|
    t.string "work_name"
    t.float "time_rate"
    t.string "note"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "educational_works", force: :cascade do |t|
    t.string "work_name"
    t.float "time_rate"
    t.string "note"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "files_excels", force: :cascade do |t|
    t.string "input_file"
    t.string "output_file"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_files_excels_on_user_id"
  end

  create_table "organizational_and_methodical_works", force: :cascade do |t|
    t.string "work_name"
    t.float "time_rate"
    t.string "note"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "research_works", force: :cascade do |t|
    t.string "work_name"
    t.float "time_rate"
    t.string "note"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "subjects", force: :cascade do |t|
    t.string "subject_name"
    t.string "course"
    t.integer "semester"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "training_direction"
    t.string "group_quantity"
    t.integer "student_b_quantity"
    t.integer "student_c_quantity"
    t.float "lectures"
    t.float "practical_classes"
    t.float "laboratory_classes"
    t.float "modular_control_b"
    t.float "consultation_semester_b"
    t.float "consultation_exam_b"
    t.float "test_b"
    t.float "exam_b"
    t.float "modular_control_c"
    t.float "consultation_semester_c"
    t.float "consultation_exam_c"
    t.float "test_c"
    t.float "exam_c"
    t.index ["user_id"], name: "index_subjects_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.string "surname"
    t.string "username"
    t.string "avatar"
    t.boolean "admin", default: false
    t.string "post"
    t.string "academic_degree"
    t.float "rate"
    t.string "educational_and_methodical_works"
    t.string "organizational_and_methodical_works"
    t.string "research_works"
    t.string "educational_works"
    t.string "patronymic"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "files_excels", "users"
  add_foreign_key "subjects", "users"
end
