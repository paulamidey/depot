class Order < ActiveRecord::Base
  PAYMENT_TYPES = [ "Check" , "Credit card" , "Purchase order" ]
  validates :name, :address, :email, :pay_type, :presence => true
  validates :pay_type, :inclusion => PAYMENT_TYPES
  has_many :line_items, :dependent => :destroy
  has_one :note, :dependent => :destroy
  paginates_per 10

  def add_line_items_from_cart(cart)
    cart.line_items.each do |item|
      item.cart_id = nil
      line_items << item
    end
  end

  def maximum_orders?
    count_line_items >= 5
  end

  def minimum_orders?
    count_line_items <= 5
  end

  def count_line_items
    total_items = line_items.to_a.sum{ |q| q.quantity }
  end

  def total_price
    line_items.to_a.sum{ |total| total.quantity * total.product.price }
  end

end
