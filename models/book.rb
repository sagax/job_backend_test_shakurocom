class Book < Abstract
  has_many :book_by_shops

  validates :title, uniqueness: true
  validates :title, presence: true
  validates :title, length: {minimum: 3, maximum: 100}
end
