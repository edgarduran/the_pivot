class User < ActiveRecord::Base
  has_secure_password
  validates :username, presence: true

  enum role: %w(default admin)

  has_many :orders

  def set_order(session)
    order = orders.new(current_status: 'ordered')
    order_items = session.each do |id, days|
      order.order_items.new(car_id: id, days: days)
    end
    order.total_price = order.order_items.map { |order_item| Car.find(order_item.car_id).daily_price * order_item.days }.sum
    session.delete(:cart) if order.save
  end
end
