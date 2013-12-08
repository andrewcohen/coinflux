class CreateWallets < ActiveRecord::Migration
  def change
    create_table :wallets do |t|
      t.integer :cash_value
      t.integer :btc_value
      t.references :user, index: true
      t.string :name
      t.timestamps
    end
  end
end
