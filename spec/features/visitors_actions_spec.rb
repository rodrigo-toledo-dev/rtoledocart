require 'rails_helper'


describe "Visitors actions" do
  before do
    visit root_path
  end

  scenario 'Visitor see areas' do
    expect(page).to have_content('Games')
    find('#games_order').visible?
    expect(page).to have_content('Carrinho')
  end

  context 'Visitor see products' do
    before do
      FactoryBot.create_list(:product, 6)
    end
    context "List of products" do
      scenario 'In list of products' do
        page.has_selector?('.product', count: 6)
        page.has_selector?('.products_list .image', count: 6)
        page.has_selector?('.products_list .title', count: 6)
        page.has_selector?('.products_list .price', count: 6)
        page.has_selector?('.add_to_cart', count: 6, visible: false)
      end

      # scenario 'User add product to cart', js: true do
      #   it 'Add to cart' do
      #     page.find('.description:first').trigger(:mouseover)
      #     page.has_selector?('.add_to_cart', count: 1, visible: true)
      #   end
        
      # end
    end
    
    
  

    context 'Visitor dont have products' do
      scenario 'Empty cart' do
        expect(page).to have_content('Até o momento seu carrinho está vazio')
      end
    end
  end
  

  
end