class UserMailer < ApplicationMailer
  default from: 'borrow-my-carro@example.com'

  def sample_email(user)
    @user = user
    @cars = user.orders.last.cars
    mail(to: user.email, subject: "Order #{user.orders.last.id}")
  end
end
