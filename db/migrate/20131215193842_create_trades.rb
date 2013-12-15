class CreateTrades < ActiveRecord::Migration
  def change
    create_table :trades do |t|
      t.references :wallet, index: true
      t.integer :buy_amount
      t.integer :sell_amount
      t.integer :start_btc
      t.integer :start_cash
      t.integer :end_btc
      t.integer :end_cash
      t.datetime :confirmed_at
      t.datetime :completed_at
      t.string :transaction_type

      t.timestamps
    end
  end
end
