class CreateTickerPrices < ActiveRecord::Migration
  def change
    create_table :ticker_prices do |t|
      t.integer :high
      t.integer :low
      t.integer :avg
      t.integer :vwap
      t.integer :last_local
      t.integer :last_orig
      t.integer :last
      t.integer :buy
      t.integer :sell
      t.datetime :date

      t.timestamps
    end
  end
end
