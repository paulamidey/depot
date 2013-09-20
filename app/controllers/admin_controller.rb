class AdminController < ApplicationController
 before_filter :set_cart
 def index
    @total_orders = Order.count
  end

 private

  def set_cart
    @cart = current_cart
  end
end
