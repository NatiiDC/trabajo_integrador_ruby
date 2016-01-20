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

ActiveRecord::Schema.define(version: 20160117231644) do

  create_table "clients", force: :cascade do |t|
    t.string   "firstname"
    t.string   "lastname"
    t.date     "born"
    t.string   "type_document_cd"
    t.integer  "number_document"
    t.string   "code"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "contact_types", force: :cascade do |t|
    t.string   "name_cd"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "contacts", force: :cascade do |t|
    t.string   "contact"
    t.integer  "client_id"
    t.integer  "contact_type_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "contacts", ["client_id"], name: "index_contacts_on_client_id"
  add_index "contacts", ["contact_type_id"], name: "index_contacts_on_contact_type_id"

  create_table "invoices", force: :cascade do |t|
    t.text     "description"
    t.decimal  "amount"
    t.date     "date_issue"
    t.integer  "person_id"
    t.integer  "client_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "invoices", ["client_id"], name: "index_invoices_on_client_id"
  add_index "invoices", ["person_id"], name: "index_invoices_on_person_id"

  create_table "people", force: :cascade do |t|
    t.string   "name"
    t.string   "code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
