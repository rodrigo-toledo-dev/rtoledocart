require 'rails_helper'


describe "Visitors actions" do
  scenario 'Visitor see areas' do
    visit root_path
    expect(page).to have_content('Games')
    find('#games_order').visible?
    # expect(page) has_field?('games_order')
    expect(page).to have_content('Carrinho')
    # page.has_select?('#games_order').should be_true
  end
end