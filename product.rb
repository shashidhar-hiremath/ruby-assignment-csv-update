class Product
  attr_accessor :id, :name, :price, :quantity, :manufacturer

  def initialize(id, name, price, quantity, manufacturer)
    @id = id
    @name = name
    @price = price.to_f
    @quantity = quantity.to_i
    @manufacturer = manufacturer
  end

  def update_quantity(quantity)
    @quantity -= quantity
  end

  def to_hash
    {
      "id" => @id,
      "name" => @name,
      "price" => @price,
      "quantity" => @quantity,
      "manufacturer" => @manufacturer
    }
  end
end
