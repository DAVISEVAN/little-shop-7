require 'rails_helper'

RSpec.describe 'Merchant Items Index', type: :feature do
  before :each do
    @merchant = Merchant.create!(name: "Test Merchant")

    @item1 = Item.create!(name: "Item 1", description: "Description 1", unit_price: 100, merchant: @merchant)
    @item2 = Item.create!(name: "Item 2", description: "Description 2", unit_price: 200, merchant: @merchant)
  end

  it 'displays a list of items for the merchant' do
    visit merchant_items_path(@merchant)

    [@item1, @item2].each do |item|
      expect(page).to have_content(item.name)
    end
  end
end
