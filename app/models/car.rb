class Car < ActiveRecord::Base
  validates :model, :make, :year, :description, :daily_price, presence: true
  validates :daily_price, :year, numericality: true

  belongs_to :location
  belongs_to :store
  has_many :order_items

  has_many :orders, through: :order_items

  # def self.search(query)
  #   where('LOWER(brand) ILIKE ?', "%#{query}%") |
  #     where('LOWER(name) ILIKE ?', "%#{query}%") |
  #     where('LOWER(description) ILIKE ?', "%#{query}%")
  # end

  def full_name
    "#{year} #{make} #{model}"
  end
end
