require 'rails_helper'

RSpec.describe "Merchant Item Creation", type: :feature do
  before(:each) do
    @merchant = Merchant.create!(name: "Test Merchant")
    visit merchant_items_path(@merchant)
  end

  it "allows the merchant to create a new item" do
    # User Story 11: Merchant Item Create
    click_link 'New Item'
    expect(current_path).to eq(new_merchant_item_path(@merchant))

    fill_in 'Name', with: 'New Item'
    fill_in 'Description', with: 'New Description'
    fill_in 'Unit price', with: 300
    click_button 'Submit'

    expect(current_path).to eq(merchant_items_path(@merchant))
    within('#disabled-items') do
      expect(page).to have_content('New Item')
    end
  end
end
