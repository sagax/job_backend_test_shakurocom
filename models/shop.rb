class Shop < Abstract
  has_many :book_by_shops

  validates :name, uniqueness: true
  validates :name, presence: true
  validates :name, length: {minimum: 3, maximum: 100}
end
