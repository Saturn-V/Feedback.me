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

ActiveRecord::Schema.define(version: 20170308040450) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "answers", force: :cascade do |t|
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "response_id"
    t.integer  "value_static"
    t.string   "value_free"
    t.integer  "competency_id"
    t.index ["competency_id"], name: "index_answers_on_competency_id", using: :btree
    t.index ["response_id"], name: "index_answers_on_response_id", using: :btree
  end

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "form_id"
    t.index ["form_id"], name: "index_categories_on_form_id", using: :btree
  end

  create_table "classrooms", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "name"
    t.string   "class_code"
    t.string   "subject"
    t.index ["class_code"], name: "index_classrooms_on_class_code", unique: true, using: :btree
  end

  create_table "classrooms_users", id: false, force: :cascade do |t|
    t.integer "classroom_id"
    t.integer "user_id"
    t.index ["classroom_id"], name: "index_classrooms_users_on_classroom_id", using: :btree
    t.index ["user_id"], name: "index_classrooms_users_on_user_id", using: :btree
  end

  create_table "competencies", force: :cascade do |t|
    t.boolean  "static"
    t.boolean  "free"
    t.string   "label"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "category_id"
    t.index ["category_id"], name: "index_competencies_on_category_id", using: :btree
  end

  create_table "competencies_skills", id: false, force: :cascade do |t|
    t.integer "competency_id"
    t.integer "skill_id"
    t.index ["competency_id"], name: "index_competencies_skills_on_competency_id", using: :btree
    t.index ["skill_id"], name: "index_competencies_skills_on_skill_id", using: :btree
  end

  create_table "feedback_requests", force: :cascade do |t|
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "user_id"
    t.integer  "classroom_id"
    t.integer  "form_id"
    t.index ["classroom_id"], name: "index_feedback_requests_on_classroom_id", using: :btree
    t.index ["form_id"], name: "index_feedback_requests_on_form_id", using: :btree
    t.index ["user_id"], name: "index_feedback_requests_on_user_id", using: :btree
  end

  create_table "forms", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.string   "assesment_type"
    t.integer  "created_by_id"
    t.index ["created_by_id"], name: "index_forms_on_created_by_id", using: :btree
  end

  create_table "forms_classrooms", id: false, force: :cascade do |t|
    t.integer "form_id"
    t.integer "classroom_id"
    t.index ["classroom_id"], name: "index_forms_classrooms_on_classroom_id", using: :btree
    t.index ["form_id"], name: "index_forms_classrooms_on_form_id", using: :btree
  end

  create_table "notifications", force: :cascade do |t|
    t.integer  "recipient_id"
    t.integer  "sender_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "response_id"
    t.index ["response_id"], name: "index_notifications_on_response_id", using: :btree
  end

  create_table "responses", force: :cascade do |t|
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.integer  "form_id"
    t.integer  "user_id"
    t.integer  "classroom_id"
    t.boolean  "is_complete",         default: false
    t.integer  "feedback_request_id"
    t.index ["classroom_id"], name: "index_responses_on_classroom_id", using: :btree
    t.index ["feedback_request_id"], name: "index_responses_on_feedback_request_id", using: :btree
    t.index ["form_id"], name: "index_responses_on_form_id", using: :btree
    t.index ["user_id"], name: "index_responses_on_user_id", using: :btree
  end

  create_table "skills", force: :cascade do |t|
    t.string   "label"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.boolean  "instructor",             default: true
    t.boolean  "student",                default: false
    t.string   "first_name"
    t.string   "last_name"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "answers", "competencies"
  add_foreign_key "answers", "responses"
  add_foreign_key "categories", "forms"
  add_foreign_key "competencies", "categories"
  add_foreign_key "feedback_requests", "classrooms"
  add_foreign_key "feedback_requests", "forms"
  add_foreign_key "feedback_requests", "users"
  add_foreign_key "notifications", "responses"
  add_foreign_key "responses", "classrooms"
  add_foreign_key "responses", "feedback_requests"
  add_foreign_key "responses", "forms"
  add_foreign_key "responses", "users"
end
