class CreateChickens < ActiveRecord::Migration[8.1]
  def change
    create_table :chickens do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name
      t.decimal :weight
      t.string :weight_class
      t.integer :record_wins
      t.integer :record_losses
      t.string :status

      t.timestamps
    end
  end
end
