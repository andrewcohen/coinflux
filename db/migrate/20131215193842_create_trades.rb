class CreateTrades < ActiveRecord::Migration
  def change
    create_table :trades do |t|
      t.references :wallet, index: true
      t.column :buy_amount, :bigint
      t.column :sell_amount, :bigint
      t.column :start_btc, :bigint
      t.column :start_cash, :bigint
      t.column :end_btc, :bigint
      t.column :end_cash, :bigint
      t.datetime :confirmed_at
      t.datetime :completed_at
      t.string :transaction_type

      t.timestamps
    end
  end
end
