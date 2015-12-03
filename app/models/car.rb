class Car < ActiveRecord::Base
  has_attached_file :image, styles: { medium: '300x300>', thumb: '100x100>' }, default_url: 'shredding_brah2.png'
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
  # validates :name, :description, :price, presence: true
  # validates :price, numericality: true

  belongs_to :location
  belongs_to :store
  has_many :order_items
  has_many :orders, through: :order_items

  def self.search(query)
    where('LOWER(brand) ILIKE ?', "%#{query}%") |
      where('LOWER(name) ILIKE ?', "%#{query}%") |
      where('LOWER(description) ILIKE ?', "%#{query}%")
  end

  def self.current_featured
    Car.first
  end

  def full_name
    "#{year} #{make} #{model}"
  end
end
