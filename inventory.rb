require 'csv'
require_relative 'product'

class Inventory
  attr_accessor :products, :file_path

  def initialize(file_path)
    @file_path = file_path
    @products = []
    load
  end

  def load
    @products.clear
    CSV.foreach(@file_path, headers: true) do |row|
      @products << Product.new(row['id'], row['name'], row['price'], row['quantity'], row['manufacturer'])
    end
  rescue Errno::ENOENT
    puts "Inventory file not found, creating a new one."
    save
  end

  def save
    CSV.open(@file_path, "w") do |csv|
      csv << ["id", "name", "price", "quantity", "manufacturer"]
      @products.each { |p| csv << p.to_hash.values }
    end
  end

  def view_all
    @products
  end

  def search(keyword)
    @products.select { |p| p.name.downcase.include?(keyword.downcase) }
  end

  def add_product(product)
    @products << product
    save
  end

  def update_product(id, name: nil, price: nil, quantity: nil, manufacturer: nil)
    prod = get_product_by_id(id)
    return false unless prod

    prod.name = name if name
    prod.price = price if price
    prod.quantity = quantity if quantity
    prod.manufacturer = manufacturer if manufacturer
    save
    true
  end

  def get_product_by_id(id)
    @products.find { |p| p.id == id }
  end
end
