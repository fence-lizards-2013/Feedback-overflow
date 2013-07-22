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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130721001543) do

  create_table "cohorts", :force => true do |t|
    t.string   "name"
    t.string   "location"
    t.string   "status"
    t.string   "email"
    t.integer  "cohort_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "comments", :force => true do |t|
    t.text     "content"
    t.integer  "topic_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "user_id"
  end

  create_table "scores", :force => true do |t|
    t.integer  "specific"
    t.integer  "actionable"
    t.integer  "kind"
    t.integer  "user_id"
    t.integer  "topic_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "scores", ["user_id", "topic_id"], :name => "index_scores_on_user_id_and_topic_id", :unique => true

  create_table "topics", :force => true do |t|
    t.string   "title"
    t.text     "content"
    t.integer  "user_id"
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
    t.string   "slug"
    t.integer  "upvotes_count", :default => 0
    t.boolean  "anonymous",     :default => false
  end

  create_table "upvotes", :force => true do |t|
    t.integer "user_id"
    t.integer "topic_id"
  end

  add_index "upvotes", ["user_id", "topic_id"], :name => "index_upvotes_on_user_id_and_topic_id", :unique => true

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.integer  "cohort_id"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.string   "remember_token"
    t.string   "avatar"
    t.string   "name_slug"
    t.boolean  "socrates_auth",   :default => false
  end

  add_index "users", ["remember_token"], :name => "index_users_on_remember_token"

end
