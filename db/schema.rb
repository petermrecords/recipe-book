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

ActiveRecord::Schema.define(version: 2019_02_18_041052) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: :cascade do |t|
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "email", null: false
    t.string "password_digest", null: false
    t.datetime "discarded_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
  end

  create_table "groceries", force: :cascade do |t|
    t.string "grocery_name", null: false
    t.text "description"
    t.string "grocery_type", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["grocery_name"], name: "index_groceries_on_grocery_name", unique: true
  end

  create_table "ingredients", force: :cascade do |t|
    t.bigint "recipe_id", null: false
    t.bigint "grocery_id", null: false
    t.bigint "measurement_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "amount", null: false
    t.string "measurement_override"
    t.string "comment"
    t.index ["grocery_id"], name: "index_ingredients_on_grocery_id"
    t.index ["measurement_id"], name: "index_ingredients_on_measurement_id"
    t.index ["recipe_id", "grocery_id"], name: "unique_ingredient_index", unique: true
    t.index ["recipe_id"], name: "index_ingredients_on_recipe_id"
  end

  create_table "measurements", force: :cascade do |t|
    t.string "measurement_name", null: false
    t.string "abbreviation"
    t.string "measurement_type", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "recipes", force: :cascade do |t|
    t.string "dish_name", null: false
    t.text "description"
    t.integer "serves"
    t.bigint "admin_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["admin_id"], name: "index_recipes_on_admin_id"
    t.index ["dish_name"], name: "index_recipes_on_dish_name", unique: true
  end

end
