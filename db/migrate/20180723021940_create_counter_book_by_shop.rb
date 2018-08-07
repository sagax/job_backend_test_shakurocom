class CreateCounterBookByShop < ActiveRecord::Migration[5.2]
  def self.up
    create_table :counter_book_by_shops do |t|
      t.integer :count
      t.belongs_to :book_by_shop
      t.timestamps
    end
  end

  def self.down
    drop_table :counter_book_by_shops
  end
end
