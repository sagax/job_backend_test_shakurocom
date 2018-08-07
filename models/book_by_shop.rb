class BookByShop < ActiveRecord::Base
  belongs_to :shop
  belongs_to :book
  has_one :counter_book_by_shop
  has_many :sell_by_shop_and_books

  validates :shop, presence: true
  validates :book, presence: true
end
