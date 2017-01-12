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

ActiveRecord::Schema.define(version: 20170112174957) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "transportation_expense_patterns", force: :cascade do |t|
    t.string  "name"
    t.integer "transportation_expense_id"
  end

  create_table "transportation_expenses", force: :cascade do |t|
    t.string   "destination"
    t.string   "route"
    t.string   "destination_from"
    t.string   "destination_to"
    t.boolean  "is_round_trip"
    t.integer  "cost"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.date     "use_date"
  end

  create_table "work_time_patterns", force: :cascade do |t|
    t.time     "work_started_at"
    t.time     "work_ended_at"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "name"
  end

  create_table "work_time_records", force: :cascade do |t|
    t.datetime "created_at",                                           null: false
    t.datetime "updated_at",                                           null: false
    t.integer  "work_time_pattern_id"
    t.time     "rest_time",            default: '2000-01-01 01:00:00'
    t.time     "work_started_at"
    t.time     "work_ended_at"
    t.text     "description",          default: ""
    t.date     "work_date"
    t.boolean  "is_late"
    t.boolean  "is_leave_work_early"
    t.boolean  "is_absent"
  end

end
