class CartController < ApplicationController
  #POST /cart
  def create
    # log product id to the terminal logger
    logger.debug("Adding #{params[:id]} to cart.")
    id = params[:id].to_i
    session[:shopping_cart] << id unless session[:shopping_cart].include?(id) #pushes id onto the end of array
    game = Game.find(id)
    flash[:notice] = "+ #{game.title} added to cart..."
    redirect_to root_path
  end

  #DELETE /cart/:id
  def destroy
    logger.debug("Removing #{params[:id]} from cart.")
    id = params[:id].to_i
    session[:shopping_cart].delete(id)
    # ToDo - add notification...
    redirect_to root_path
  end
end
