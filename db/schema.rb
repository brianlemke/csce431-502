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

ActiveRecord::Schema.define(:version => 20130408001154) do

  create_table "comments", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.text     "body"
    t.integer  "poster_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "comments", ["poster_id"], :name => "index_comments_on_poster_id"

  create_table "organizations", :force => true do |t|
    t.string   "email"
    t.string   "name"
    t.string   "description"
    t.string   "password_digest"
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
    t.string   "login_token"
    t.boolean  "verified",        :default => true
  end

  add_index "organizations", ["email"], :name => "index_organizations_on_email", :unique => true
  add_index "organizations", ["login_token"], :name => "index_organizations_on_login_token"

  create_table "posters", :force => true do |t|
    t.string   "file"
    t.string   "title"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.string   "organization_id"
    t.string   "location"
    t.datetime "event_start_date"
    t.datetime "event_end_date"
  end

  add_index "posters", ["organization_id"], :name => "index_posters_on_organization_id"

  create_table "subscriptions", :force => true do |t|
    t.integer  "user_id"
    t.integer  "organization_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "subscriptions", ["user_id", "organization_id"], :name => "index_subscriptions_on_user_id_and_organization_id"

  create_table "userSavedPosters", :force => true do |t|
    t.integer "userID"
    t.integer "posterID"
  end

  add_index "userSavedPosters", ["userID", "posterID"], :name => "index_userSavedPosters_on_userID_and_posterID"

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.string   "login_token"
    t.string   "name"
    t.boolean  "admin",           :default => false
    t.string   "picture"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["login_token"], :name => "index_users_on_login_token"

end
