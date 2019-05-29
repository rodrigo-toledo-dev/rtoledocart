require 'faker'
class Cart
  attr_accessor :id, :product_ids, :current_products
  def initialize(id = nil)
    if id.nil?
      self.id = Faker::Number.number(10)
    else
      self.id = id
    end
    self.product_ids ||= []
  end

  def empty?
    self.product_ids.blank?
  end

  def products
    self.product_ids.map do |product_id|
      Product.find(product_id)
    end
  end

  def remove_product(product_id)
    return false unless self.product_ids.include?(product_id)
    self.product_ids.delete_at(self.product_ids.index(product_id))
  end

  def total_with_freight
    total + freight
  end

  def total
    products.sum(&:price)
  end

  def freight
    return 0 if total > 250
    10*product_ids.count
  end
end