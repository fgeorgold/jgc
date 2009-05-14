# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20090512223055) do

  create_table "activities", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.text     "resources"
    t.text     "cost"
    t.text     "comments"
    t.string   "duration"
    t.text     "instructions"
    t.string   "programs"
    t.string   "age_group"
    t.string   "category"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "visible",      :default => false
  end

  create_table "categories", :force => true do |t|
    t.string "activity_id"
    t.string "category_name"
  end

  create_table "comments", :force => true do |t|
    t.text   "comment_text"
    t.string "email"
    t.string "name"
  end

  create_table "organizations", :force => true do |t|
    t.string   "name"
    t.string   "website"
    t.text     "description"
    t.text     "resources"
    t.string   "contact"
    t.string   "email"
    t.string   "partners"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "visible",     :default => false
    t.text     "asp"
  end

  create_table "partners", :force => true do |t|
    t.string "organization_id"
    t.string "partner_org_id"
  end

  create_table "pd_users", :force => true do |t|
    t.string "screen_name"
    t.string "email"
    t.string "password"
  end

  create_table "programs", :force => true do |t|
    t.string "activity_id"
    t.string "program_name"
  end

  create_table "users", :force => true do |t|
    t.string   "login"
    t.string   "hashed_password"
    t.string   "email"
    t.string   "salt"
    t.datetime "created_at"
    t.boolean  "admin",           :default => false
    t.string   "affiliateOrg"
    t.boolean  "activitesadmin",  :default => false
    t.boolean  "mailpref",        :default => true
  end

end
