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

ActiveRecord::Schema.define(version: 20170727053110) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "attendances", force: :cascade do |t|
    t.integer  "attendee_id"
    t.integer  "event_attended_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.index ["attendee_id"], name: "index_attendances_on_attendee_id", using: :btree
    t.index ["event_attended_id"], name: "index_attendances_on_event_attended_id", using: :btree
  end

  create_table "events", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.string   "venue"
    t.datetime "time_start"
    t.datetime "time_end"
    t.integer  "host_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["created_at"], name: "index_events_on_created_at", using: :btree
    t.index ["host_id"], name: "index_events_on_host_id", using: :btree
  end

  create_table "invites", force: :cascade do |t|
    t.integer  "inviter_id"
    t.integer  "invitee_id"
    t.integer  "event_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_invites_on_event_id", using: :btree
    t.index ["invitee_id"], name: "index_invites_on_invitee_id", using: :btree
    t.index ["inviter_id"], name: "index_invites_on_inviter_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["email"], name: "index_users_on_email", using: :btree
  end

  add_foreign_key "attendances", "events", column: "event_attended_id"
  add_foreign_key "attendances", "users", column: "attendee_id"
  add_foreign_key "events", "users", column: "host_id"
  add_foreign_key "invites", "events"
  add_foreign_key "invites", "users", column: "invitee_id"
  add_foreign_key "invites", "users", column: "inviter_id"
end
