class NotesController < ApplicationController

  before_action :set_cart ,:set_user

  def index
    @notes = Note.all
  end

  def new
    @order = Order.find(params[:order_id])
    @note =  @order.build_note
  end

  def edit
    @order = Order.find(params[:order_id])
  end

  def create
    @order = Order.find(params[:order_id])
    @note = @order.build_note(note_params)
    if @note.save!
      redirect_to orders_path, notice: 'Note was successfully created.'
    else
      render action: 'new'
    end
  end

   def update
    if @note.update(note_params)
      redirect_to orders_path, notice: 'Note was successfully updated.'
    else
      render action: 'edit'
    end
  end

private

    def note_params
      params.require(:note).permit(:title, :note ,:order_id)
    end

    def set_cart
      @cart = current_cart
    end

    def set_user
      @usr = current_user
    end
end
