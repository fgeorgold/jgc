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

ActiveRecord::Schema.define(:version => 20090804205956) do

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
    t.string   "created_by"
    t.text     "address"
    t.text     "lat"
    t.text     "lon"
  end

  create_table "activities_comments", :force => true do |t|
    t.string  "activity_id"
    t.text    "comment_text"
    t.string  "email"
    t.boolean "visible",      :default => false
  end

  create_table "activities_favorites", :force => true do |t|
    t.string "Pduser_id"
    t.string "activitiy_id"
  end

  create_table "asps", :force => true do |t|
    t.string "organization_id"
    t.string "program_name"
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

  create_table "emails", :force => true do |t|
    t.text     "from"
    t.text     "to"
    t.text     "mail"
    t.text     "subject"
    t.datetime "created_at"
    t.datetime "updated_at"
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
    t.text     "address"
  end

  create_table "partners", :force => true do |t|
    t.string "organization_id"
    t.string "partner_org_id"
  end

  create_table "pd_users", :force => true do |t|
    t.string "login_name"
    t.string "email"
    t.string "password"
    t.string "authorization_token"
  end

  create_table "personal_lives", :force => true do |t|
    t.integer "pd_user_id",          :null => false
    t.text    "bio"
    t.text    "academic_background"
    t.text    "interests"
    t.text    "other_info"
  end

  create_table "professional_lives", :force => true do |t|
    t.integer "pd_user_id",              :null => false
    t.date    "start_date"
    t.text    "past_work_experience"
    t.float   "years_of_work"
    t.text    "social_activities"
    t.text    "skills"
    t.text    "future_plans"
    t.text    "desired_job_description"
    t.integer "desired_salary_per_year"
  end

  create_table "programs", :force => true do |t|
    t.string "activity_id"
    t.string "program_name"
  end

  create_table "ratings", :force => true do |t|
    t.integer  "rating",                      :default => 0
    t.datetime "created_at",                                  :null => false
    t.string   "rateable_type", :limit => 15, :default => "", :null => false
    t.integer  "rateable_id",                 :default => 0,  :null => false
    t.integer  "user_id",                     :default => 0,  :null => false
  end

  add_index "ratings", ["user_id"], :name => "fk_ratings_user"

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "specs", :force => true do |t|
    t.integer "pd_user_id",                       :null => false
    t.string  "first_name",       :default => ""
    t.string  "last_name",        :default => ""
    t.string  "gender"
    t.date    "birthdate"
    t.string  "occupation",       :default => ""
    t.string  "city",             :default => ""
    t.string  "state",            :default => ""
    t.string  "zip_code",         :default => ""
    t.string  "address",          :default => ""
    t.string  "work_phone",       :default => ""
    t.string  "fax",              :default => ""
    t.string  "home_phone",       :default => ""
    t.string  "cell_phone",       :default => ""
    t.string  "current_employee", :default => ""
    t.string  "age_group",        :default => ""
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
    t.boolean  "edit_perms",      :default => false
  end

end
