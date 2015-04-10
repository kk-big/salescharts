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

ActiveRecord::Schema.define(version: 20150407053118) do

  create_table "access_logs", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "ip_address"
    t.string   "user_id"
    t.text     "url"
    t.string   "action"
    t.text     "parameters"
  end

  create_table "inspections", force: :cascade do |t|
    t.string   "user_id"
    t.string   "inspection_ym"
    t.integer  "onemonth"
    t.integer  "sixmonth"
    t.integer  "years"
    t.integer  "years_not"
    t.integer  "inspection"
    t.integer  "inspection_not"
    t.integer  "insurance_new"
    t.integer  "insurance_renew"
    t.integer  "insurance_cancel"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "inspections", ["inspection_ym"], name: "index_inspections_on_inspection_ym", using: :btree
  add_index "inspections", ["user_id"], name: "index_inspections_on_user_id", using: :btree

  create_table "plans", force: :cascade do |t|
    t.string   "user_id"
    t.string   "plan_ym"
    t.integer  "customer"
    t.integer  "newcar"
    t.integer  "usedcar"
    t.integer  "onemonth"
    t.integer  "sixmonth"
    t.integer  "years"
    t.integer  "inspection"
    t.integer  "insurance"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.integer  "newcar_balance"
    t.integer  "registration_plan"
  end

  add_index "plans", ["plan_ym"], name: "index_plans_on_plan_ym", using: :btree
  add_index "plans", ["user_id"], name: "index_plans_on_user_id", using: :btree

  create_table "profits", force: :cascade do |t|
    t.string   "user_id"
    t.string   "profit_ym"
    t.integer  "number_of_newcar"
    t.integer  "sales_of_newcar"
    t.integer  "profit_of_newcar"
    t.integer  "number_of_usedcar"
    t.integer  "sales_of_usedcar"
    t.integer  "profit_of_usedcar"
    t.integer  "number_of_service"
    t.integer  "sales_of_service"
    t.integer  "profit_of_service"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "profits", ["profit_ym"], name: "index_profits_on_profit_ym", using: :btree
  add_index "profits", ["user_id"], name: "index_profits_on_user_id", using: :btree

  create_table "results", force: :cascade do |t|
    t.string   "user_id"
    t.string   "result_ym"
    t.string   "result_date"
    t.integer  "negotiations"
    t.integer  "assessment"
    t.integer  "testdrive"
    t.integer  "newcar_new"
    t.integer  "newcar_replace"
    t.integer  "newcar_add"
    t.integer  "newcar_introduce"
    t.integer  "newcar_cash"
    t.integer  "newcar_credit"
    t.integer  "newcar_credit_re"
    t.integer  "registration_possible"
    t.integer  "registration_result"
    t.integer  "usedcar"
    t.integer  "onemonth"
    t.integer  "sixmonth"
    t.integer  "years"
    t.integer  "years_not"
    t.integer  "inspection"
    t.integer  "inspection_not"
    t.integer  "insurance_new"
    t.integer  "insurance_renew"
    t.integer  "insurance_cancel"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.integer  "wholesale"
    t.integer  "registration_plan_update"
  end

  add_index "results", ["result_date"], name: "index_results_on_result_date", using: :btree
  add_index "results", ["result_ym"], name: "index_results_on_result_ym", using: :btree
  add_index "results", ["user_id"], name: "index_results_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "user_id"
    t.string   "user_password"
    t.string   "user_name"
    t.integer  "emp_no"
    t.string   "position"
    t.string   "job"
    t.string   "role"
    t.integer  "display_order"
    t.string   "delete_flag"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

end
