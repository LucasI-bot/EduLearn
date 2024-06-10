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

ActiveRecord::Schema[7.0].define(version: 2024_06_10_141715) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "ckeditor_assets", force: :cascade do |t|
    t.string "data_file_name", null: false
    t.string "data_content_type"
    t.integer "data_file_size"
    t.string "data_fingerprint"
    t.string "type", limit: 30
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["type"], name: "index_ckeditor_assets_on_type"
  end

  create_table "contents", force: :cascade do |t|
    t.integer "content_type"
    t.string "text"
    t.bigint "lecture_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["lecture_id"], name: "index_contents_on_lecture_id"
  end

  create_table "conversations", force: :cascade do |t|
    t.bigint "teacher_id"
    t.bigint "student_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["student_id"], name: "index_conversations_on_student_id"
    t.index ["teacher_id"], name: "index_conversations_on_teacher_id"
  end

  create_table "courses", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "price"
    t.datetime "start_date"
    t.datetime "end_date"
    t.datetime "inscription_start_date"
    t.datetime "inscription_end_date"
    t.boolean "visibility"
    t.boolean "acceptance_required"
    t.bigint "user_id"
    t.string "detailed_description"
    t.float "rating"
    t.index ["user_id"], name: "index_courses_on_user_id"
  end

  create_table "courses_skills", force: :cascade do |t|
    t.bigint "skill_id"
    t.bigint "course_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_courses_skills_on_course_id"
    t.index ["skill_id"], name: "index_courses_skills_on_skill_id"
  end

  create_table "courses_subjects", force: :cascade do |t|
    t.bigint "subject_id"
    t.bigint "course_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_courses_subjects_on_course_id"
    t.index ["subject_id"], name: "index_courses_subjects_on_subject_id"
  end

  create_table "exam_answers", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "exam_id"
    t.boolean "finished"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "mark"
    t.boolean "active"
    t.index ["exam_id"], name: "index_exam_answers_on_exam_id"
    t.index ["user_id"], name: "index_exam_answers_on_user_id"
  end

  create_table "exams", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "course_id"
    t.bigint "section_id"
    t.integer "position"
    t.index ["course_id"], name: "index_exams_on_course_id"
    t.index ["section_id"], name: "index_exams_on_section_id"
  end

  create_table "inscriptions", force: :cascade do |t|
    t.boolean "approved"
    t.boolean "paid"
    t.bigint "user_id"
    t.bigint "course_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "mark"
    t.integer "rating"
    t.string "review"
    t.datetime "inscription_date"
    t.float "order"
    t.datetime "rating_date"
    t.index ["course_id"], name: "index_inscriptions_on_course_id"
    t.index ["user_id"], name: "index_inscriptions_on_user_id"
  end

  create_table "lectures", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "course_id"
    t.bigint "section_id"
    t.integer "position"
    t.index ["course_id"], name: "index_lectures_on_course_id"
    t.index ["section_id"], name: "index_lectures_on_section_id"
  end

  create_table "messages", force: :cascade do |t|
    t.bigint "conversation_id"
    t.bigint "user_id"
    t.string "message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["conversation_id"], name: "index_messages_on_conversation_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "option_answers", force: :cascade do |t|
    t.bigint "question_answer_id"
    t.bigint "option_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "selected"
    t.index ["option_id"], name: "index_option_answers_on_option_id"
    t.index ["question_answer_id"], name: "index_option_answers_on_question_answer_id"
  end

  create_table "options", force: :cascade do |t|
    t.string "option"
    t.boolean "correct"
    t.bigint "question_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["question_id"], name: "index_options_on_question_id"
  end

  create_table "payments", force: :cascade do |t|
    t.bigint "inscription_id"
    t.float "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["inscription_id"], name: "index_payments_on_inscription_id"
  end

  create_table "question_answers", force: :cascade do |t|
    t.bigint "exam_answer_id"
    t.bigint "question_id"
    t.string "answer"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "question_number"
    t.boolean "correct"
    t.index ["exam_answer_id"], name: "index_question_answers_on_exam_answer_id"
    t.index ["question_id"], name: "index_question_answers_on_question_id"
  end

  create_table "questions", force: :cascade do |t|
    t.string "question"
    t.string "answer"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "exam_id"
    t.integer "question_number"
    t.integer "question_type"
    t.index ["exam_id"], name: "index_questions_on_exam_id"
  end

  create_table "sections", force: :cascade do |t|
    t.string "title"
    t.bigint "course_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "position"
    t.index ["course_id"], name: "index_sections_on_course_id"
  end

  create_table "skills", force: :cascade do |t|
    t.string "skill", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "skills_users", force: :cascade do |t|
    t.bigint "skill_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["skill_id"], name: "index_skills_users_on_skill_id"
    t.index ["user_id"], name: "index_skills_users_on_user_id"
  end

  create_table "subjects", force: :cascade do |t|
    t.string "subject", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "subjects_users", force: :cascade do |t|
    t.bigint "subject_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["subject_id"], name: "index_subjects_users_on_subject_id"
    t.index ["user_id"], name: "index_subjects_users_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "password_digest", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "role"
    t.string "first_name"
    t.string "last_name"
    t.string "alias"
    t.float "rating"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "courses", "users"
  add_foreign_key "exams", "courses"
  add_foreign_key "lectures", "courses"
  add_foreign_key "options", "questions"
  add_foreign_key "questions", "exams"
  add_foreign_key "sections", "courses"
end
