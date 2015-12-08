class Location < ActiveRecord::Base
  validates :name, presence: true
  before_save :set_slug
  has_many :cars

  def set_slug
    self.slug = name.parameterize
  end
end
