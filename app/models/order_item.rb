class OrderItem < ActiveRecord::Base
  belongs_to :car
  belongs_to :order
  belongs_to :store
  belongs_to :user

  def store_slug
    Store.find(self.store_id).slug
  end

  def store_name
    Store.find(self.store_id).name
  end

  def car
    Car.find(self.car_id)
  end

  def current_status
    self.order.current_status.capitalize
  end

  def total_price
    Car.find(self.car_id).daily_price * self.days
  end
end
