class OrderItem < ActiveRecord::Base
  belongs_to :car
  belongs_to :order
  belongs_to :store
  belongs_to :user
end
