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

ActiveRecord::Schema.define(:version => 20081008144524) do

  create_table "loinc_lab_codes", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "code"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "message_headers", :force => true do |t|
    t.string  "sending_application"
    t.string  "sending_facility"
    t.string  "receiving_application"
    t.string  "receiving_facility"
    t.date    "message_date"
    t.string  "message_type"
    t.string  "message_control_identifier"
    t.integer "patient_id"
    t.string  "processing_id_field"
  end

  create_table "observation_requests", :force => true do |t|
    t.string  "ordering_provider"
    t.integer "patient_id"
    t.integer "loinc_lab_code_id"
  end

  create_table "observations", :force => true do |t|
    t.string  "value_type"
    t.string  "observation_value"
    t.string  "units"
    t.string  "reference_range"
    t.string  "abnormal_flags"
    t.integer "patient_id"
    t.integer "loinc_lab_code_id"
    t.string  "result_status"
  end

  create_table "patients", :force => true do |t|
    t.string   "identifier"
    t.string   "family_name"
    t.string   "given_name"
    t.date     "date_of_birth"
    t.string   "administrative_sex"
    t.string   "street_address"
    t.string   "city"
    t.string   "state"
    t.string   "postal_code"
    t.string   "country"
    t.string   "home_phone"
    t.string   "business_phone"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "received_messages", :force => true do |t|
    t.text     "message_contents"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "validation_errors", :force => true do |t|
    t.string   "message"
    t.string   "location"
    t.integer  "received_message_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
