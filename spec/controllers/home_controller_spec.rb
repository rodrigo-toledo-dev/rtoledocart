require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  describe 'HomeController' do
    before(:each) do
      HomeController.send(:public, *HomeController.protected_instance_methods)  
    end
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
end