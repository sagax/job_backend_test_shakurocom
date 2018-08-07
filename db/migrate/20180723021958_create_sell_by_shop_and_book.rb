class CreateSellByShopAndBook < ActiveRecord::Migration[5.2]
  def self.up
    create_table :sell_by_shop_and_books do |t|
      t.integer :amount
      t.belongs_to :book_by_shop
      t.timestamps
    end
  end

  def self.down
    drop_table :sell_by_shop_and_books
  end
end
