class CreateDepthTickers < ActiveRecord::Migration
  def change
    create_table :depth_tickers do |t|
      t.column :price, :bigint
      t.column :volume, :bigint
      t.integer :type_num
      t.string :type_str
      t.string :item
      t.string :currency
      t.column :total_volume, :bigint

      t.timestamps
    end
  end
end
