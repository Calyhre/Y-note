# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20140227164147) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "answers", force: true do |t|
    t.integer  "returned_exam_id"
    t.integer  "question_id"
    t.text     "answer"
    t.float    "points"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  create_table "choices", force: true do |t|
    t.integer  "question_id"
    t.string   "title"
    t.boolean  "correct"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  create_table "comments", force: true do |t|
    t.integer  "user_id"
    t.integer  "parent_id"
    t.string   "parent_type"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  create_table "contestations", force: true do |t|
    t.integer  "user_id"
    t.integer  "test_id"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  create_table "courses", force: true do |t|
    t.integer  "teacher_id"
    t.integer  "group_id"
    t.integer  "subject_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  create_table "groups", force: true do |t|
    t.integer  "period_id"
    t.string   "title"
    t.string   "role"
    t.integer  "parent_id"
    t.integer  "lft"
    t.integer  "rgt"
    t.integer  "depth"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  create_table "groups_users", force: true do |t|
    t.integer "user_id"
    t.integer "group_id"
  end

  create_table "periods", force: true do |t|
    t.string   "title"
    t.integer  "parent_id"
    t.integer  "lft"
    t.integer  "rgt"
    t.integer  "depth"
    t.datetime "start_at"
    t.datetime "end_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  create_table "questions", force: true do |t|
    t.integer  "test_id"
    t.string   "title"
    t.text     "instruction"
    t.text     "correction"
    t.string   "question_type"
    t.integer  "position"
    t.float    "max_points"
    t.string   "penalty_type"
    t.float    "penalty"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  create_table "returned_exams", force: true do |t|
    t.integer  "user_id"
    t.integer  "test_id"
    t.float    "grade"
    t.text     "appreciation"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  create_table "subjects", force: true do |t|
    t.string   "title"
    t.integer  "parent_id"
    t.integer  "lft"
    t.integer  "rgt"
    t.integer  "depth"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "delete_at"
  end

  create_table "tests", force: true do |t|
    t.integer  "course_id"
    t.string   "title"
    t.text     "instruction"
    t.string   "penalty_type"
    t.float    "penalty"
    t.boolean  "anonymous"
    t.string   "grading_scheme"
    t.float    "coefficient"
    t.datetime "start_at"
    t.datetime "end_at"
    t.datetime "contestation_closed_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "first_name"
    t.string   "last_name"
    t.date     "birthdate"
    t.string   "gender"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
