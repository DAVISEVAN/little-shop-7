require 'rails_helper'

RSpec.describe 'Merchant Items Show', type: :feature do
  before :each do
    @merchant = Merchant.create!(name: 'Test Merchant')
    @item = @merchant.items.create!(name: 'Item 1', description: 'Description 1', unit_price: 100)
  end

  # User Story 7
  it 'displays all item attributes' do
    visit merchant_item_path(@merchant, @item)

    expect(page).to have_content(@item.name)
    expect(page).to have_content(@item.description)
    expect(page).to have_content(@item.unit_price)
  end
end
