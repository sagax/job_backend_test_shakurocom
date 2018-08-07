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

ActiveRecord::Schema.define(version: 2018_07_23_021958) do

  create_table "book_by_shops", force: :cascade do |t|
    t.integer "book_id"
    t.integer "shop_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["book_id"], name: "index_book_by_shops_on_book_id"
    t.index ["shop_id"], name: "index_book_by_shops_on_shop_id"
  end

  create_table "books", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "counter_book_by_shops", force: :cascade do |t|
    t.integer "count"
    t.integer "book_by_shop_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["book_by_shop_id"], name: "index_counter_book_by_shops_on_book_by_shop_id"
  end

  create_table "sell_by_shop_and_books", force: :cascade do |t|
    t.integer "amount"
    t.integer "book_by_shop_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["book_by_shop_id"], name: "index_sell_by_shop_and_books_on_book_by_shop_id"
  end

  create_table "shops", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
