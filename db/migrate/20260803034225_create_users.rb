class CreateUsers < ActiveRecord::Migration[8.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.integer :role
      t.decimal :wallet_balance

      t.timestamps
    end
  end
end
