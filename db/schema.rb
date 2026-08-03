# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.1].define(version: 2026_08_03_034504) do
  create_table "bets", force: :cascade do |t|
    t.decimal "amount"
    t.string "chosen_corner"
    t.datetime "created_at", null: false
    t.integer "match_card_id", null: false
    t.decimal "payout"
    t.integer "status"
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.index ["match_card_id"], name: "index_bets_on_match_card_id"
    t.index ["user_id"], name: "index_bets_on_user_id"
  end

  create_table "chickens", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name"
    t.integer "record_losses"
    t.integer "record_wins"
    t.string "status"
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.decimal "weight"
    t.string "weight_class"
    t.index ["user_id"], name: "index_chickens_on_user_id"
  end

  create_table "match_cards", force: :cascade do |t|
    t.integer "blue_corner_chicken_id", null: false
    t.datetime "created_at", null: false
    t.decimal "odds_blue"
    t.decimal "odds_red"
    t.integer "red_corner_chicken_id", null: false
    t.datetime "scheduled_at"
    t.integer "status"
    t.string "title"
    t.datetime "updated_at", null: false
    t.index ["blue_corner_chicken_id"], name: "index_match_cards_on_blue_corner_chicken_id"
    t.index ["red_corner_chicken_id"], name: "index_match_cards_on_red_corner_chicken_id"
  end

  create_table "match_results", force: :cascade do |t|
    t.text "admin_notes"
    t.datetime "created_at", null: false
    t.integer "duration_seconds"
    t.integer "match_card_id", null: false
    t.datetime "updated_at", null: false
    t.string "win_method"
    t.integer "winning_chicken_id", null: false
    t.index ["match_card_id"], name: "index_match_results_on_match_card_id"
    t.index ["winning_chicken_id"], name: "index_match_results_on_winning_chicken_id"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email"
    t.string "name"
    t.string "password_digest"
    t.integer "role"
    t.datetime "updated_at", null: false
    t.decimal "wallet_balance"
  end

  add_foreign_key "bets", "match_cards"
  add_foreign_key "bets", "users"
  add_foreign_key "chickens", "users"
  add_foreign_key "match_cards", "blue_corner_chickens"
  add_foreign_key "match_cards", "red_corner_chickens"
  add_foreign_key "match_results", "match_cards"
  add_foreign_key "match_results", "winning_chickens"
end
