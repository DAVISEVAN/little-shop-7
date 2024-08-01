require 'rails_helper'

RSpec.describe 'Merchant Item Update', type: :feature do
  before :each do
    @merchant = Merchant.create!(name: 'Test Merchant')
    @item = @merchant.items.create!(name: 'Item 1', description: 'Description 1', unit_price: 100)
  end

  # User Story 8
  it 'allows merchant to update item information' do
    visit merchant_item_path(@merchant, @item)
    click_link 'Edit'

    fill_in 'Name', with: 'Updated Item'
    fill_in 'Description', with: 'Updated Description'
    fill_in 'Unit price', with: 200
    click_button 'Update Item'

    expect(page).to have_content('Item was successfully updated.')
    expect(page).to have_content('Updated Item')
    expect(page).to have_content('Updated Description')
    expect(page).to have_content(200)
  end
end
