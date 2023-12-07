class CartController < ApplicationController
  #POST /cart
  def create
    puts "Create action called!"
    logger.debug("Adding #{params[:id]} to cart.")
    id = params[:id].to_i
    quantity = params[:quantity].to_i

    # Ensure the cart is initialized
    session[:shopping_cart] ||= {}

    # Check if the game is already in the cart
    if session[:shopping_cart].key?(id)
      # If the game is already in the cart, update the quantity
      session[:shopping_cart][id][:quantity] += quantity
    else
      # If the game is not in the cart, add it with the specified quantity
      game = Game.find(id)
      session[:shopping_cart][id] = { quantity: quantity, title: game.title, price: game.price }
      flash[:notice] = "+ #{quantity} #{'game'.pluralize(quantity)} added to cart..."
      puts "items in session: #{session[:shopping_cart]}"
    end

    respond_to do |format|
      format.html { redirect_back fallback_location: root_path }
      format.js   { render js: "window.location.reload();" }
    end
  end




  # DELETE /cart/:id
  def destroy
    puts "Destroy action called!"
    logger.debug("Removing #{params[:id]} from cart.")
    id = params[:id].to_s

    puts "Before removal: #{session[:shopping_cart].inspect}"


    if session[:shopping_cart].key?(id)
      session[:shopping_cart].delete(id)
      game = Game.find(id)
      flash[:notice] = "- #{game.title} removed from cart..."

      # Save the session changes manually
      session[:shopping_cart] = session[:shopping_cart]
    else
      flash[:alert] = "Item not found in cart."
    end

    puts "After removal: #{session[:shopping_cart].inspect}"

    respond_to do |format|
      format.html { redirect_back fallback_location: root_path }
      format.js { render js: "window.location.reload();" }
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
