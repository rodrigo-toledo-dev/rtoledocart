Rails.application.routes.draw do
  root 'home#index'
  get '/order-products', to: 'home#order_products', as: :order_products
  get '/add-to-cart/:cart_id/:id', to: 'home#add_to_cart', as: :add_to_cart
  delete '/remove-from-cart/:cart_id/:id', to: 'home#remove_from_cart', as: :remove_from_cart
end
