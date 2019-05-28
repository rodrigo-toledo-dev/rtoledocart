class HomeController < ApplicationController
  helper_method :current_cart
  before_action :set_products, only: [:index, :add_to_cart]
  def index
    session[:product_ids] = []
  end


  def add_to_cart
    session[:product_ids] << params[:id]
    current_cart.product_ids = session[:product_ids]
  end

  protected
    def current_cart
      @current_cart ||= Cart.new(params[:cart_id])
    end

    def set_products
      @products = Product.order(params[:order] || :name)
    end
end
