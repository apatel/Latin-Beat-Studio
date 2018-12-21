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

<<<<<<< Updated upstream
ActiveRecord::Schema.define(version: 20171223203349) do
=======
ActiveRecord::Schema.define(version: 20171021213500) do
>>>>>>> Stashed changes

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "class_registrations", force: :cascade do |t|
    t.integer  "fullcalendar_engine_events_id"
    t.integer  "class_type_id"
    t.integer  "user_id"
    t.integer  "purchase_id"
    t.boolean  "attended"
    t.boolean  "no_show"
    t.datetime "class_date"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.index ["class_type_id"], name: "index_class_registrations_on_class_type_id", using: :btree
    t.index ["purchase_id"], name: "index_class_registrations_on_purchase_id", using: :btree
    t.index ["user_id"], name: "index_class_registrations_on_user_id", using: :btree
  end

  create_table "class_types", force: :cascade do |t|
    t.string   "name",                                    null: false
    t.text     "description"
    t.boolean  "active",                   default: true
    t.string   "class_image_file_name"
    t.string   "class_image_content_type"
    t.integer  "class_image_file_size"
    t.datetime "class_image_updated_at"
    t.integer  "purchase"
    t.string   "color"
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.index ["name"], name: "index_class_types_on_name", unique: true, using: :btree
  end

  create_table "class_types_instructors", id: false, force: :cascade do |t|
    t.integer "class_type_id", null: false
    t.integer "instructor_id", null: false
  end

  create_table "class_types_passes", id: false, force: :cascade do |t|
    t.integer "class_type_id", null: false
    t.integer "pass_id",       null: false
    t.index ["class_type_id", "pass_id"], name: "index_class_types_passes_on_class_type_id_and_pass_id", using: :btree
  end

  create_table "contents", force: :cascade do |t|
    t.string   "title"
    t.text     "body"
    t.string   "page"
    t.string   "section"
    t.string   "content_image_file_name"
    t.string   "content_image_content_type"
    t.integer  "content_image_file_size"
    t.datetime "content_image_updated_at"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "fullcalendar_engine_event_series", force: :cascade do |t|
    t.integer  "frequency",     default: 1
    t.string   "period",        default: "monthly"
    t.datetime "starttime"
    t.datetime "endtime"
    t.boolean  "all_day",       default: false
    t.integer  "class_type_id"
    t.integer  "location_id"
    t.integer  "instructor_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "fullcalendar_engine_events", force: :cascade do |t|
    t.string   "title"
    t.datetime "starttime"
    t.datetime "endtime"
    t.boolean  "all_day",         default: false
    t.text     "description"
    t.integer  "event_series_id"
    t.integer  "class_type_id"
    t.integer  "location_id"
    t.integer  "instructor_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["event_series_id"], name: "index_fullcalendar_engine_events_on_event_series_id", using: :btree
  end

  create_table "instructors", force: :cascade do |t|
    t.string   "name"
    t.string   "title"
    t.text     "playlist"
    t.integer  "user_id"
    t.string   "instructor_image_file_name"
    t.string   "instructor_image_content_type"
    t.integer  "instructor_image_file_size"
    t.datetime "instructor_image_updated_at"
    t.string   "fb_handle"
    t.string   "fb_link"
    t.string   "ig_handle"
    t.string   "ig_link"
    t.text     "bio"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.integer  "view_order"
    t.index ["user_id"], name: "index_instructors_on_user_id", using: :btree
  end

  create_table "locations", force: :cascade do |t|
    t.string   "name",                       null: false
    t.integer  "capacity"
    t.text     "description"
    t.boolean  "active",      default: true
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.index ["name"], name: "index_locations_on_name", unique: true, using: :btree
  end

  create_table "pages", force: :cascade do |t|
    t.string   "title"
    t.string   "code"
    t.text     "content"
    t.boolean  "show_in_menu"
    t.integer  "purchase"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "pass_types", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "view_order"
  end

  create_table "passes", force: :cascade do |t|
    t.string   "name",                            null: false
    t.text     "description"
    t.float    "price"
    t.integer  "expiration_days", default: 30
    t.integer  "quantity"
    t.boolean  "active",          default: true
    t.string   "embed_code"
    t.integer  "purchase"
    t.string   "category"
    t.integer  "view_order"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "expiration_text"
    t.string   "quantity_text"
    t.boolean  "single_purchase", default: false
  end

  create_table "purchases", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "pass_id"
    t.datetime "expire"
    t.boolean  "paid",           default: false
    t.boolean  "suspend",        default: false
    t.datetime "suspend_start"
    t.datetime "suspend_end"
    t.integer  "remaining_days"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.index ["pass_id"], name: "index_purchases_on_pass_id", using: :btree
    t.index ["user_id"], name: "index_purchases_on_user_id", using: :btree
  end

  create_table "studio_events", force: :cascade do |t|
    t.string   "name",                     null: false
    t.datetime "start_date"
    t.datetime "end_date"
    t.text     "description"
    t.float    "price"
    t.string   "url"
    t.string   "button_text"
    t.boolean  "active"
    t.string   "event_image_file_name"
    t.string   "event_image_content_type"
    t.integer  "event_image_file_size"
    t.datetime "event_image_updated_at"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                   default: "",    null: false
    t.string   "username",                default: "",    null: false
    t.string   "encrypted_password",      default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.boolean  "admin",                   default: false
    t.boolean  "staff",                   default: false
    t.boolean  "waiver",                  default: false, null: false
    t.string   "first_name"
    t.string   "last_name"
    t.string   "phone"
    t.string   "address1"
    t.string   "address2"
    t.string   "city"
    t.string   "state"
    t.integer  "zip"
    t.date     "birthday"
    t.string   "emergency_contact_name"
    t.string   "emergency_contact_phone"
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.date     "waiver_date"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
    t.index ["username"], name: "index_users_on_username", unique: true, using: :btree
  end

end
