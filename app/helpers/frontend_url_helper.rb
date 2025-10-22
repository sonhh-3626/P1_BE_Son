module FrontendUrlHelper
  def frontend_order_url(order)
    "#{ENV['FRONTEND_URL']}/orders/#{order.id}"
  end
end
