class CreateBookByShop < ActiveRecord::Migration[5.2]
  def self.up
    create_table :book_by_shops do |t|
      t.belongs_to :book
      t.belongs_to :shop
      t.timestamps
    end
  end

  def self.down
    drop_table :book_by_shops
  end
end
