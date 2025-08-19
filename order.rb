class Order
  attr_accessor :id, :name, :credit_no, :cvv

  def initialize(id, name, credit_no, cvv)
    @id = id
    @name = name
    @credit_no = credit_no
    @cvv = cvv
  end

  def to_hash
    {
      "id" => @id,
      "name" => @name,
      "credit_no" => @credit_no,
      "cvv" => @cvv
    }
  end
end
