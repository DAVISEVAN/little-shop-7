require 'rails_helper'

RSpec.describe 'Merchant Items Index', type: :feature do
  before(:each) do
    @merchant = Merchant.create!(name: "Test Merchant")
    @item1 = @merchant.items.create!(name: "Item 1", description: "Description 1", unit_price: 100, status: :enabled)
    @item2 = @merchant.items.create!(name: "Item 2", description: "Description 2", unit_price: 200, status: :disabled)
  end
# User Story 6, displays item names on items index
  it 'displays a list of the names of all of my items' do
    visit merchant_items_path(@merchant)
    expect(page).to have_content(@item1.name)
    expect(page).to have_content(@item2.name)
  end
# User Story 9, toggles item status
  it 'allows the merchant to toggle item status' do
    visit merchant_items_path(@merchant)
    within("#item-#{@item1.id}") do
      click_button 'Disable'
    end
    @item1.reload
    expect(@item1.status).to eq('disabled')

    within("#item-#{@item2.id}") do
      click_button 'Enable'
    end
    @item2.reload
    expect(@item2.status).to eq('enabled')
  end
# User Story 10, displays items grouped by status
  it 'displays items grouped by status' do
    visit merchant_items_path(@merchant)
    within('#enabled-items') do
      expect(page).to have_content(@item1.name)
    end
    within('#disabled-items') do
      expect(page).to have_content(@item2.name)
    end
  end
end

