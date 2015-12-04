class User < ActiveRecord::Base
  has_secure_password
  validates :username, presence: true

  has_many :user_roles
  has_many :roles, through: :user_roles

  has_many :orders

  def set_order(session)
    order = orders.new(current_status: 'ordered')
    order_items = session.each do |item_id, quantity|
      order.order_items.new(item_id: item_id, quantity: quantity)
    end
    order.total_price = order.order_items.map { |order_item| Item.find(order_item.item_id).price * order_item.quantity }.sum
    session.delete(:cart) if order.save
  end

  def platform_admin?
    roles.exists?(name: "platform_admin")
  end

  def store_admin?
    roles.exists?(name: "store_admin")
  end

  def registered_user?
    roles.exists?(name: "registered_user")
  end
end
