class Store < ActiveRecord::Base
  has_many :cars
  has_many :users
  validates :slug, presence: true, uniqueness: true

  before_validation :generate_slug

  def generate_slug
    self.slug = name.parameterize
  end
end
