require_relative 'inventory'
require_relative 'order_manager'

def place_order(inventory, order_manager, product_id, quantity, customer_name, credit_no, cvv)
  product = inventory.get_product_by_id(product_id)
  
  if product && product.quantity >= quantity
    product.update_quantity(quantity)
    inventory.save

    order = Order.new(product_id, customer_name, credit_no, cvv)
    order_manager.create_order(order)

    puts "Order placed successfully for #{quantity} #{product.name}(s)"
  else
    puts "Product not found or insufficient quantity."
  end
end

# Example run
inventory = Inventory.new("inventory.csv")
orders = OrderManager.new("orders.csv")

# View all products
def view_all_products(inventory)
  puts "ID | Name | Price | Stock | Company"
  inventory.view_all.each do |product|
    puts "#{product.id} | #{product.name} | #{product.price} | #{product.quantity} | #{product.manufacturer}"
  end
end
# view_all_products(inventory)

# Add new product
# inventory.add_product(Product.new("105", "Mobile", 750, 110, "Motorola"))
# view_all_products(inventory)

# Search products
# puts "ID | Name | Price | Stock | Company"
# inventory.search("Mob").each { |p| puts "#{p.id} | #{p.name} | #{p.price} | #{p.quantity} | #{p.manufacturer}" }

# Place an order
# place_order(inventory, orders, "104", 3, "Raj", "566852", "852")

# View all orders
def view_all_orders(orders)
    puts "\n Orders List:"
    puts "ID | Name | Credit No | CVV"
    orders.view_all.each do |order|
        puts "#{order.id} | #{order.name} | Credit No: #{order.credit_no} | CVV: #{order.cvv}"
    end
end
view_all_orders(orders)

