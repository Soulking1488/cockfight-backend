class CreateMatchCards < ActiveRecord::Migration[8.1]
  def change
    create_table :match_cards do |t|
      t.string :title
      t.datetime :scheduled_at
      t.references :red_corner_chicken, null: false, foreign_key: true
      t.references :blue_corner_chicken, null: false, foreign_key: true
      t.integer :status
      t.decimal :odds_red
      t.decimal :odds_blue

      t.timestamps
    end
  end
end
