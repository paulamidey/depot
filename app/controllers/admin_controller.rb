class AdminController < ApplicationController
  before_filter :set_cart

  before_filter :set_user

  def index
    @total_orders = Order.count
    @usr = current_user
  end

  private

  def set_cart
    @cart = current_cart
  end

  def set_user
    @usr = current_user
  end

end

