class CreateWallets < ActiveRecord::Migration
  def change
    create_table :wallets do |t|
      t.column :cash_value, :bigint
      t.column :btc_value, :bigint
      t.references :user, index: true
      t.string :name
      t.timestamps
    end
  end
end
