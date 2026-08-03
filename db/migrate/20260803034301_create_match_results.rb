class CreateMatchResults < ActiveRecord::Migration[8.1]
  def change
    create_table :match_results do |t|
      t.references :match_card, null: false, foreign_key: true
      t.references :winning_chicken, null: false, foreign_key: true
      t.string :win_method
      t.integer :duration_seconds
      t.text :admin_notes

      t.timestamps
    end
  end
end
