class User < ActiveRecord::Base
  has_secure_password
  validates :username, presence: true

  has_many :user_roles
  has_many :roles, through: :user_roles

  has_many :orders
  has_many :order_items
  belongs_to :store
  after_save :add_default_user_role

  def set_order(session)
    order = orders.new
    order_items = session.each do |id, days|
      order.order_items.new(car_id: id,
                            days: days,
                            store_id: Car.find(id).store.id,
                            user_id: order.user_id)
    end
    order.total_price = order.order_items.map { |order_item| Car.find(order_item.car_id).daily_price * order_item.days }.sum
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

  def add_default_user_role
    self.roles.create(name: 'registered_user')
  end
end
