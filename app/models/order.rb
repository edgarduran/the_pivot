class Order < ActiveRecord::Base
  belongs_to :user
  has_many :order_items
  has_many :cars, through: :order_items

  validates :current_status, presence: true,
                             inclusion: { in: %w(completed ordered paid canceled) }

  before_create :total_price

  scope :completed, -> { where(current_status: 'completed') }
  scope :paid,      -> { where(current_status: 'paid') }
  scope :canceled,  -> { where(current_status: 'canceled') }
  scope :ordered,   -> { where(current_status: 'ordered') }

  def orders_hash
    {
      order_object: self,
      total_price: total_price
    }
  end

  def total_price
    order_items.map { |order_item| Car.find(order_item.car_id).daily_price * order_item.days }.sum
  end
end
