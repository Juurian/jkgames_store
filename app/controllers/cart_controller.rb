class CartController < ApplicationController
  #POST /cart
  # POST /cart
  def create
    puts "Create action called!"
    logger.debug("Adding #{params[:id]} to cart.")
    id = params[:id].to_i

    unless session[:shopping_cart].include?(id)
      session[:shopping_cart] << id
      game = Game.find(id)
      flash[:notice] = "+ #{game.title} added to cart..."
    end
    # redirect_to root_path
    respond_to do |format|
      format.html { redirect_back fallback_location: root_path }
      format.js   { render js: "window.location.reload();" }
    end
  end


  # DELETE /cart/:id
  def destroy
    puts "Destroy action called!"
    logger.debug("Removing #{params[:id]} from cart.")
    id = params[:id].to_i
    session[:shopping_cart].delete(id)
    game = Game.find(id)
    flash[:notice] = "- #{game.title} removed from cart..."
    # ToDo - add notification...
    # redirect_to root_path
    respond_to do |format|
      format.html { redirect_back fallback_location: root_path }
      format.js   { render js: "window.location.reload();" }
    end
  end
end
