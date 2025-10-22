class OrderMailer < ApplicationMailer
  helper FrontendUrlHelper
  default from: 'no-reply@yourapp.com'

  def order_confirmation(order)
    @order = order
    @user = order.user
    mail(
      to: "ha.hong.son@sun-asterisk.com", # @user.email,
      subject: "Xác nhận đơn hàng ##{order.id}"
    )
  end
end
