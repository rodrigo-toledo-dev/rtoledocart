require 'faker'
class Cart
  attr_accessor :id, :product_ids, :current_products
  def initialize(id = nil)
    self.id = id || Faker::Number.number(10)
    self.product_ids = []
  end

  def empty?
    self.product_ids.blank?
  end

  def products
    self.product_ids.map do |product_id|
      Product.find(product_id)
    end
  end

  def total_without_freight
    total - freight
  end

  def total
    products.sum(&:price)
  end

  def freight
    return 0 if total > 250
    10*product_ids.count
  end
end