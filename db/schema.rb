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

ActiveRecord::Schema.define(version: 20160910223155) do

  create_table "checks", force: :cascade do |t|
    t.boolean  "recieved"
    t.datetime "recieved_time"
    t.boolean  "primary"
    t.datetime "primary_time"
    t.boolean  "secondary"
    t.datetime "secondary_time"
    t.boolean  "accountant"
    t.datetime "accountant_time"
    t.boolean  "upload"
    t.datetime "upload_time"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.text     "note"
  end

  create_table "customers", force: :cascade do |t|
    t.string   "code"
    t.string   "name_abrev"
    t.string   "name"
    t.string   "reg_addr"
    t.string   "contact_addr"
    t.string   "declare_type"
    t.string   "contact"
    t.string   "phone"
    t.string   "cellphone"
    t.string   "fax"
    t.string   "email"
    t.string   "fee"
    t.integer  "officer_id"
    t.integer  "leader_id"
    t.integer  "manager_id"
    t.string   "status"
    t.date     "start_date"
    t.text     "note_1"
    t.text     "note_2"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "tasks", force: :cascade do |t|
    t.integer  "year"
    t.integer  "customer_id"
    t.integer  "vat_jan"
    t.integer  "vat_mar"
    t.integer  "vat_may"
    t.integer  "vat_jul"
    t.integer  "vat_sept"
    t.integer  "vat_nov"
    t.integer  "voucher"
    t.integer  "income_tax"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "code"
    t.string   "name"
    t.string   "password_digest"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

end
