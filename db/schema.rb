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

ActiveRecord::Schema.define(version: 20170310140906) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "unaccent"

  create_table "attachinary_files", force: :cascade do |t|
    t.string   "attachinariable_type"
    t.integer  "attachinariable_id"
    t.string   "scope"
    t.string   "public_id"
    t.string   "version"
    t.integer  "width"
    t.integer  "height"
    t.string   "format"
    t.string   "resource_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["attachinariable_type", "attachinariable_id", "scope"], name: "by_scoped_parent", using: :btree
  end

  create_table "categories", force: :cascade do |t|
    t.text     "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "opening_hours", force: :cascade do |t|
    t.string   "day"
    t.time     "open_time"
    t.time     "closed_time"
    t.integer  "shop_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["shop_id"], name: "index_opening_hours_on_shop_id", using: :btree
  end

  create_table "ordered_products", force: :cascade do |t|
    t.integer  "product_id"
    t.float    "quantity"
    t.float    "order_price"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "order_id"
    t.index ["order_id"], name: "index_ordered_products_on_order_id", using: :btree
    t.index ["product_id"], name: "index_ordered_products_on_product_id", using: :btree
  end

  create_table "orders", force: :cascade do |t|
    t.datetime "pick_up_at"
    t.integer  "user_id"
    t.text     "instructions"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.integer  "shop_id"
    t.integer  "status",            default: 0, null: false
    t.integer  "total_price_cents", default: 0, null: false
    t.json     "payment"
    t.index ["shop_id"], name: "index_orders_on_shop_id", using: :btree
    t.index ["user_id"], name: "index_orders_on_user_id", using: :btree
  end

  create_table "product_categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "products", force: :cascade do |t|
    t.integer  "product_category_id"
    t.string   "name"
    t.text     "description"
    t.string   "short_description"
    t.float    "price"
    t.string   "measurement_units"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.integer  "shop_id"
    t.index ["product_category_id"], name: "index_products_on_product_category_id", using: :btree
    t.index ["shop_id"], name: "index_products_on_shop_id", using: :btree
  end

  create_table "shops", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.string   "address"
    t.string   "phone_number"
    t.string   "color_theme"
    t.integer  "user_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "product_id"
    t.float    "latitude"
    t.float    "longitude"
    t.integer  "opening_hour_id"
    t.integer  "category_id"
    t.index ["category_id"], name: "index_shops_on_category_id", using: :btree
    t.index ["opening_hour_id"], name: "index_shops_on_opening_hour_id", using: :btree
    t.index ["product_id"], name: "index_shops_on_product_id", using: :btree
    t.index ["user_id"], name: "index_shops_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "f_name"
    t.string   "l_name"
    t.string   "phone"
    t.string   "address"
    t.string   "role"
    t.string   "provider"
    t.string   "uid"
    t.string   "facebook_picture_url"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "token"
    t.datetime "token_expiry"
    t.boolean  "admin",                  default: false, null: false
    t.boolean  "owner",                  default: false, null: false
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "opening_hours", "shops"
  add_foreign_key "ordered_products", "products"
  add_foreign_key "orders", "shops"
  add_foreign_key "orders", "users"
  add_foreign_key "products", "product_categories"
  add_foreign_key "products", "shops"
  add_foreign_key "shops", "products"
  add_foreign_key "shops", "users"
end
