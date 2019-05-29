require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  describe 'HomeController' do
    before(:each) do
      HomeController.send(:public, *HomeController.protected_instance_methods)  
    end

    describe 'cart operations' do
      context "empty cart" do
        it 'should have cart empty' do
          get :index
          expect(controller.current_cart.empty?).to be_truthy
        end
      end

      context 'cart with itens' do
        it "should add products to cart" do
          FactoryBot.create_list(:product, 5, price: 100)
          get :add_to_cart, params: {cart_id: controller.current_cart.id, id: Product.first.id}
          expect(controller.current_cart.empty?).to be_falsey
        end

        it "should remove product from cart" do
          FactoryBot.create_list(:product, 5)
          get :add_to_cart, params: {cart_id: controller.current_cart.id, id: Product.first.id}
          get :add_to_cart, params: {cart_id: controller.current_cart.id, id: Product.last.id}
          delete :remove_from_cart, params: {cart_id: controller.current_cart.id, id: Product.first.id}
          expect(controller.current_cart.products.size).to eql(1)
        end
      end
    end

    describe 'order operations' do
      context 'order by name' do
        it 'sort by name' do
          FactoryBot.create(:product, name: 'a')
          FactoryBot.create(:product, name: 'b')
          FactoryBot.create(:product, name: 'c')
          get :order_products, params: {order: :name}
          expect(controller.set_products.first).to eql(Product.first)
          expect(controller.set_products.last).to eql(Product.last)
        end
      end

      context 'order by price' do
        it 'sort by price' do
          FactoryBot.create(:product, price: 123)
          second_created = FactoryBot.create(:product, price: 789)
          FactoryBot.create(:product, price: 456)
          get :order_products, params: {order: :price}
          expect(controller.set_products.first).to eql(Product.first)
          expect(controller.set_products.last).to eql(second_created)
        end
      end

      context 'order by score' do
        it 'sort by score' do
          FactoryBot.create(:product, score: 789)
          second_created =FactoryBot.create(:product, score: 1)
          FactoryBot.create(:product, score: 1000)
          get :order_products, params: {order: :score}
          expect(controller.set_products.first).to eql(second_created)
          expect(controller.set_products.last).to eql(Product.last)
        end
      end
    end
  end
end