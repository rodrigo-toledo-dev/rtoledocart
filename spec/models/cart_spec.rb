require 'rails_helper'

describe Cart do
  

  describe 'Operations in cart' do
    context "empty cart" do
      let(:cart) { Cart.new }
      it 'should have cart empty' do
        expect(cart.empty?).to be_truthy
      end
    end

    context 'cart with itens' do
      
      let(:products) { FactoryBot.create_list(:product, 5, price: 30) }
      describe 'add products to new cart' do
        let(:cart) { Cart.new }
        it "should add products to cart" do
          products.each do |product|
            cart.product_ids << product.id
          end
          expect(cart.empty?).not_to be_truthy
          expect(cart.products.size).to eq(5)
          expect(cart.freight).to eq(50)
          expect(cart.total_with_freight).to eq(200.0)
          expect(cart.total).to eq(150.0)
        end

        it 'should have freight' do
          FactoryBot.create_list(:product, 2, price: 100).each do |product|
            cart.product_ids << product.id
          end
          expect(cart.freight).to eq(20)
          expect(cart.total).to eq(200.0)
          expect(cart.total_with_freight).to eq(220.0)
        end
  
        it 'should remove product from cart' do
          products.each do |product|
            cart.product_ids << product.id
            cart.product_ids << product.id
          end
  
          cart.remove_product(Product.first.id)
          cart.remove_product(Product.first.id)
          cart.remove_product(Product.last.id)
          expect(cart.products.size).to eq(7)
        end
      end

      describe 'add products to cart created' do
        it 'add one more product' do
          cart = Cart.new
          cart_to_update = Cart.new(cart.id)
          expect(cart.id).to eq(cart_to_update.id)
        end
      end
      

      
    end
    
  end
end