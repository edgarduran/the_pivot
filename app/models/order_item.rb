class OrderItem < ActiveRecord::Base
  belongs_to :car
  belongs_to :order
end
