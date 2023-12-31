<%= form_with(model: [@order, @user], url: create_order_from_cart_path, method: :post) do |form| %>
  <!-- Display the cart items and total -->
  <h2 class="text-white">Cart Items</h2>
  <ul>
    <% session[:shopping_cart].each do |id, details| %>
      <li>
        <%= details['title'] %> -
        Quantity: <%= details['quantity'] %> -
        Price: $<%= details['price'] %> -
        Sub Total: $<%= number_with_precision(details['quantity'].to_i * details['price'].to_f, precision: 2) %>
      </li>
    <% end %>
  </ul>

  <div id="sub_total">Sub Total: $<%= @sub_total || 0 %></div>
  <div id="pst_amount">PST: <%=@pst_rate * @sub_total %></div>
  <div id="gst_amount">GST: <%=@gst * @sub_total || 0 %></div>
  <div id="grand_total">Grand Total: $<%= (@pst_rate * @sub_total) + (@gst * @sub_total) + @sub_total || 0 %></div>

  <div id="address">Ship To: <%= @address %></div>

  <%= form.submit "Place Order", name: "place_order_button" %>
<% end %>