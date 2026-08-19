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

ActiveRecord::Schema[7.2].define(version: 2026_08_19_170826) do
  create_table "exam_periods", force: :cascade do |t|
    t.string "stage"
    t.string "exam_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "active"
    t.integer "year"
  end

  create_table "exam_request_subjects", force: :cascade do |t|
    t.integer "exam_request_id", null: false
    t.integer "subject_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["exam_request_id"], name: "index_exam_request_subjects_on_exam_request_id"
    t.index ["subject_id"], name: "index_exam_request_subjects_on_subject_id"
  end

  create_table "exam_requests", force: :cascade do |t|
    t.integer "student_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "reason"
    t.text "reason_description"
    t.integer "exam_period_id"
    t.boolean "same_shift", default: false, null: false
    t.date "application_date"
    t.index ["exam_period_id"], name: "index_exam_requests_on_exam_period_id"
    t.index ["student_id"], name: "index_exam_requests_on_student_id"
  end

  create_table "school_classes", force: :cascade do |t|
    t.string "grade"
    t.string "identifier"
    t.string "shift"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "students", force: :cascade do |t|
    t.string "name"
    t.integer "school_class_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "aee", default: false, null: false
    t.index ["school_class_id"], name: "index_students_on_school_class_id"
  end

  create_table "subjects", force: :cascade do |t|
    t.string "name"
    t.string "code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "test_application_school_classes", force: :cascade do |t|
    t.integer "test_application_id", null: false
    t.integer "school_class_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["school_class_id"], name: "index_test_application_school_classes_on_school_class_id"
    t.index ["test_application_id", "school_class_id"], name: "index_test_applications_on_application_and_class", unique: true
    t.index ["test_application_id"], name: "index_test_application_school_classes_on_test_application_id"
  end

  create_table "test_applications", force: :cascade do |t|
    t.string "exam_type", null: false
    t.date "application_date", null: false
    t.string "subject_name", null: false
    t.string "invigilator"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "exam_request_subjects", "exam_requests"
  add_foreign_key "exam_request_subjects", "subjects"
  add_foreign_key "exam_requests", "exam_periods"
  add_foreign_key "exam_requests", "students"
  add_foreign_key "students", "school_classes"
  add_foreign_key "test_application_school_classes", "school_classes"
  add_foreign_key "test_application_school_classes", "test_applications"
end
