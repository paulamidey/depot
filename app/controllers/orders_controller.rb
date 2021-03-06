class OrdersController < ApplicationController
  before_filter :set_cart
  before_filter :set_user
  before_action :set_order, only: [:show, :edit, :update, :destroy ]

  skip_before_filter :authorize, :only => [:new, :create]

  # GET /orders
  # GET /orders.json
  def index
    @usr = current_user
    @orders = Order.order(:name).page(params[:page]).per(2)
    respond_to do |format|
      format.html # index.html.erb
      format.xml { render :xml => @orders }
    end
  end


  # GET /orders/1
  # GET /orders/1.json
  def show
    @usr = current_user
    @count = @order.count_line_items
    @line_items = @order.line_items
    @total_price = @order.total_price
  end

  # GET /orders/new
  def new
    @cart = current_cart
    @usr = current_user
    if @cart.line_items.empty?
      redirect_to store_url, :notice => "Your cart is empty"
      return
    end
    @order = Order.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml { render :xml => @order }
    end
  end


  # GET /orders/1/edit
  def edit
  end

  # POST /orders
  # POST /orders.json
  def create
    @cart = current_cart
    @usr = current_user
    @order = @usr.orders.new(order_params)
    @order.add_line_items_from_cart(current_cart)
    respond_to do |format|
      if @order.save
        Cart.destroy(session[:cart_id])
        session[:cart_id] = nil

        Notifier.order_received(@order).deliver

        format.html { redirect_to(store_url, :notice => 'Thank you for your order.' ) }
        format.xml { render :xml => @order, :status => :created, :location => @order }

      else
        format.html { render :action => "new" }
        format.xml { render :xml => @order.errors,:status => :unprocessable_entity }
      end
    end
  end


  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url }
      format.json { head :no_content }
    end
  end

  def my_orders
    @user = current_user
    order = @user.orders
    if params[:order] == "max"
      @orders= order.select{ |list| list.maximum_orders? }
    else if   params[:order] == "min"
           @orders = order.select { |list| list.minimum_orders? }
         else
           @orders=order
         end
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_order
    @order = Order.find(params[:id])
  end

    # Never trust parameters from the scary internet, only allow the white list through.
  def order_params
    params.require(:order).permit(:name, :address, :email, :pay_type)
  end

  def set_cart
    @cart = current_cart
  end

  def set_user
    @usr = current_user
  end

end
