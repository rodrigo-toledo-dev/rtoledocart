class Product < ApplicationRecord
  validates :name, :price, :score, presence: true
  has_one_attached :image
end
