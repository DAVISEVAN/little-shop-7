require 'rails_helper'

RSpec.describe 'Merchant Items Index', type: :feature do
  before :each do
    @merchant = FactoryBot.create(:merchant)
    @items = FactoryBot.create_list(:item, 5, merchant: @merchant)
  end

  it 'displays a list of items for the merchant' do
    visit merchant_items_path(@merchant)

    @items.each do |item|
      within('ul') do
        expect(page).to have_content(item.name)
      end
    end
  end
end
