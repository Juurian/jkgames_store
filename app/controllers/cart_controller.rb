class CartController < ApplicationController
  #POST /cart
  def create
    puts "Create action called!"
    logger.debug("Adding #{params[:id]} to cart.")
    id = params[:id].to_i
    price = params[:price].to_f

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

  def show
    # Fetch the items from the cart
    @cart_items = fetch_cart_items
  end

  private

  def fetch_cart_items
    cart_ids = session[:shopping_cart] || [] # Ensure the cart is not nil
    Game.where(id: cart_ids).map do |game|
      { id: game.id, title: game.title, quantity: count_item_in_cart(game.id), price: game.price }
    end
  end

  def count_item_in_cart(game_id)
    session[:shopping_cart].count(game_id)
  end
end
