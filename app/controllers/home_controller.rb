class HomeController < ApplicationController
  helper_method :current_cart
  before_action :set_products, only: [:index, :order_products, :add_to_cart, :remove_from_cart]
  def index
    session[:product_ids] = []
  end

  def order_products
    respond_to do |format|
      format.html { head :no_content }
      format.js { render action: 'order_products' }
    end
  end

  def add_to_cart
    session[:product_ids] ||= []
    session[:product_ids] << params[:id]
    current_cart.product_ids = session[:product_ids]
    respond_to do |format|
      format.html { head :no_content }
      format.js { render action: 'reload_cart' }
    end
  end

  def remove_from_cart
    current_cart.product_ids = session[:product_ids]
    current_cart.remove_product(params[:id])
    session[:product_ids] = current_cart.product_ids
    respond_to do |format|
      format.html { head :no_content }
      format.js { render action: 'reload_cart' }
    end
  end

  protected
    def current_cart
      @current_cart ||= Cart.new(params[:cart_id])
    end

    def set_products
      @products = Product.order(params[:order] || :name)
    end
end
