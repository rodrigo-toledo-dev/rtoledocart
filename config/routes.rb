Rails.application.routes.draw do
  root 'home#index'
  get '/home/:cart_id/:id', to: 'home#add_to_cart', as: :add_to_cart
end
