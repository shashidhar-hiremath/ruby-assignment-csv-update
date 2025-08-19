require 'csv'
require_relative 'order'

class OrderManager
  attr_accessor :orders, :file_path

  def initialize(file_path)
    @file_path = file_path
    @orders = []
    load
  end

  def load
    @orders.clear
    CSV.foreach(@file_path, headers: true) do |row|
      @orders << Order.new(row['id'], row['name'], row['credit_no'], row['cvv'])
    end
  rescue Errno::ENOENT
    puts "Orders file not found, creating a new one."
    save
  end

  def save
    CSV.open(@file_path, "w") do |csv|
      csv << ["id", "name", "credit_no", "cvv"]
      @orders.each { |o| csv << o.to_hash.values }
    end
  end

  def create_order(order)
    @orders << order
    save
  end
  
  def view_all
    @orders
  end
end
