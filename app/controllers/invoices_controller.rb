class InvoicesController < ApplicationController
  def show
    # Fetch order details here based on the order ID
    @order = Order.find(params[:id])
  end
end
