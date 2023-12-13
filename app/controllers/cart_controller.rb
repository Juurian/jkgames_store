class CartController < ApplicationController
  before_action :authenticate_user!, only: [:checkout]
  #POST /cart
  def create
    puts "Create action called!"
    logger.debug("Adding #{params[:id]} to cart.")
    id = params[:id].to_i
    puts id.class
    quantity = params[:quantity].to_i
    puts quantity.class

    # Ensure the cart is initialized
    session[:shopping_cart] ||= {}

    puts "#{session[:shopping_cart]}"
    # Check if the game is already in the cart
    if session[:shopping_cart].key?(id.to_s)
      # If the game is already in the cart, update the quantity
      puts "#{session[:shopping_cart].key(id.to_s)} is here"
      current_quantity = session[:shopping_cart][id.to_s]["quantity"]
      puts "quantity is #{current_quantity} and is a #{current_quantity.class}"
      session[:shopping_cart][id.to_s][:quantity] = current_quantity + quantity
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

# PATCH /cart/update/:id
def update
  id = params[:id].to_s
  quantity = params[:quantity][id].to_i

  # Update the quantity for the specified item in the cart
  if session[:shopping_cart].key?(id)
    session[:shopping_cart][id]['quantity'] = quantity
    flash[:notice] = "Quantity updated for item #{id}..."
  else
    flash[:alert] = "Item not found in cart."
  end

  redirect_back fallback_location: root_path
end

  def show
    # Fetch the items from the cart
    @cart_items = fetch_cart_items
  end

  def checkout
    @game_order = current_user.game_orders.build
    @user = current_user
    @address = current_user.address
    @gst = 0.05

    game_id = session[:shopping_cart].keys
    games = Game.where(id: game_id)
    price = games.map do |game|
      game.price * session[:shopping_cart][game.id.to_s]['quantity']
    end
    @sub_total = price.sum

    case current_user.province
    when 'MB'
      @pst_rate = 0.08 # Manitoba PST rate
    when 'AB'
      @pst_rate = 0.00 # Alberta PST rate
    when 'SK'
      @pst_rate = 0.06 # Saskatchewan PST rate
    when 'QC'
      @pst_rate = 0.09975 # Quebec PST rate
    when 'PE'
      @pst_rate = 0.10 # Prince Edward Island PST rate
    when 'ON'
      @pst_rate = 0.08 # Ontario PST rate
    when 'NB'
      @pst_rate = 0.10 # New Brunswick PST rate
    when 'NS'
      @pst_rate = 0.10 # Nova Scotia PST rate
    when 'NL'
      @pst_rate = 0.10 # Newfoundland and Labrador PST rate
    when 'BC'
      @pst_rate = 0.07 # British Columbia PST rate
    when 'NT'
      @pst_rate = 0.00 # Northwest Territories PST rate
    when 'YT'
      @pst_rate = 0.00 # Yukon PST rate
    when 'NU'
      @pst_rate = 0.00 # Nunavut PST rate
    else
      @pst_rate = 0.00 # Default PST rate
    end
  end

  def create_order_from_cart
    @game_order = current_user.game_orders.build
    @user = current_user
    @address = current_user.address
    @gst = 0.05

    game_id = session[:shopping_cart].keys
    games = Game.where(id: game_id)
    price = games.map do |game|
      game.price * session[:shopping_cart][game.id.to_s]['quantity']
    end
    @sub_total = price.sum

    case current_user.province
    when 'MB'
      @pst_rate = 0.08 # Manitoba PST rate
    when 'AB'
      @pst_rate = 0.00 # Alberta PST rate
    when 'SK'
      @pst_rate = 0.06 # Saskatchewan PST rate
    when 'QC'
      @pst_rate = 0.09975 # Quebec PST rate
    when 'PE'
      @pst_rate = 0.10 # Prince Edward Island PST rate
    when 'ON'
      @pst_rate = 0.08 # Ontario PST rate
    when 'NB'
      @pst_rate = 0.10 # New Brunswick PST rate
    when 'NS'
      @pst_rate = 0.10 # Nova Scotia PST rate
    when 'NL'
      @pst_rate = 0.10 # Newfoundland and Labrador PST rate
    when 'BC'
      @pst_rate = 0.07 # British Columbia PST rate
    when 'NT'
      @pst_rate = 0.00 # Northwest Territories PST rate
    when 'YT'
      @pst_rate = 0.00 # Yukon PST rate
    when 'NU'
      @pst_rate = 0.00 # Nunavut PST rate
    else
      @pst_rate = 0.00 # Default PST rate
    end

    @total_with_tax = (@pst_rate * @sub_total) + (@gst * @sub_total) + @sub_total

    @order = Order.create(user_id: current_user.id, address: @address, total_price: @total_with_tax, province: current_user.province)

    # Clear the shopping cart after creating the order
    session[:shopping_cart] = {}

    flash[:notice] = "Your order has been placed successfully!"
    redirect_to order_confirmation_path(order_id: @order.id)

  end

  # def update_cart_logic
  #   # Retrieve province and cart items from params
  #   selected_province = params[:user][:province]
  #   cart_items = session[:shopping_cart]

  #   # Calculate grand total, PST, and GST for each item
  #   grand_total = 0
  #   pst_amount = 0
  #   gst_amount = 0

  #   cart_items.each do |id, item|
  #     sub_total = item['quantity'].to_i * item['price'].to_f
  #     pst = calculate_pst(selected_province, sub_total)
  #     gst = calculate_gst(sub_total)
  #     total_with_tax = sub_total + pst + gst
  #     grand_total += total_with_tax
  #     pst_amount += pst
  #     gst_amount += gst
  #   end

  #   # Set the calculated amounts in instance variables
  #   @grand_total = grand_total
  #   @pst_amount = pst_amount
  #   @gst_amount = gst_amount

  #   # Update the grand total in the session
  #   session[:grand_total] = grand_total
  # end

  # Define the methods to calculate PST and GST
  # def calculate_pst(province, s)
  #   case province
  #   when 'MB'
  #     pst_rate = 0.08 # Manitoba PST rate
  #   when 'AB'
  #     pst_rate = 0.00 # Alberta PST rate
  #   when 'SK'
  #     pst_rate = 0.06 # Saskatchewan PST rate
  #   when 'QC'
  #     pst_rate = 0.09975 # Quebec PST rate
  #   when 'PE'
  #     pst_rate = 0.10 # Prince Edward Island PST rate
  #   when 'ON'
  #     pst_rate = 0.08 # Ontario PST rate
  #   when 'NB'
  #     pst_rate = 0.10 # New Brunswick PST rate
  #   when 'NS'
  #     pst_rate = 0.10 # Nova Scotia PST rate
  #   when 'NL'
  #     pst_rate = 0.10 # Newfoundland and Labrador PST rate
  #   when 'BC'
  #     pst_rate = 0.07 # British Columbia PST rate
  #   when 'NT'
  #     pst_rate = 0.00 # Northwest Territories PST rate
  #   when 'YT'
  #     pst_rate = 0.00 # Yukon PST rate
  #   when 'NU'
  #     pst_rate = 0.00 # Nunavut PST rate
  #   else
  #     pst_rate = 0.00 # Default PST rate
  #   end
  #   subtotal * pst_rate
  # end


  # def calculate_gst(subtotal)
  #   gst_rate = 0.05 # GST rate is 5%
  #   subtotal * gst_rate
  # end

  private

  def calculate_grand_total(cart_items)
    grand_total = 0
    cart_items.each do |id, item|
      sub_total = item['quantity'].to_i * item['price'].to_f
      pst = calculate_pst(selected_province, sub_total)
      gst = calculate_gst(sub_total)
      total_with_tax = sub_total + pst + gst
      grand_total += total_with_tax
    end
    grand_total
  end

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
