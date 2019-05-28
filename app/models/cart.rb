require 'faker'
class Cart
  attr_accessor :id, :products
  def initialize
    self.id = Faker::Number.number(10)
    self.products = []
  end


end