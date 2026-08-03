class CreateBets < ActiveRecord::Migration[8.1]
  def change
    create_table :bets do |t|
      t.references :user, null: false, foreign_key: true
      t.references :match_card, null: false, foreign_key: true
      t.string :chosen_corner
      t.decimal :amount
      t.integer :status
      t.decimal :payout

      t.timestamps
    end
  end
end
