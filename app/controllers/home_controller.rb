class HomeController < ApplicationController
  helper_method :current_cart
  def index
    @products = Product.order(params[:order] || :name)
  end

  def current_cart
    @current_cart ||= Cart.new
  end


end
