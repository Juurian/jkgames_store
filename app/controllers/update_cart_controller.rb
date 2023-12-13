class UpdateCartController < ApplicationController
  # def create_order_from_cart
  #   if params[:update_cart_button]
  #     update_cart_logic
  #   elsif params[:place_order_button]
  #     place_order_logic
  #   end
  # end

  # private

  # def update_cart_logic
  #   # Retrieve province and cart items from params
  #   selected_province = params[:user][:province]
  #   cart_items = session[:shopping_cart]

  #   # Calculate grand total, PST, and GST for each item
  #   grand_total = 0

  #   cart_items.each do |id, item|
  #     sub_total = item['quantity'].to_i * item['price'].to_f
  #     pst = calculate_pst(selected_province, sub_total)
  #     gst = calculate_gst(sub_total)
  #     total_with_tax = sub_total + pst + gst
  #     grand_total += total_with_tax


  #   end

  #   # Update the grand total in the session
  #   session[:grand_total] = grand_total
  # end

  # # Define the methods to calculate PST and GST
  # def calculate_pst(province, subtotal)
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
  #   puts "button clicked and is running"
  #   puts province
  #   subtotal * pst_rate
  # end


  # def calculate_gst(subtotal)
  #   gst_rate = 0.05 # GST rate is 5%
  #   subtotal * gst_rate
  # end

end
