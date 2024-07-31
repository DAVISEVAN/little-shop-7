require 'rails_helper'

RSpec.describe "merchant index", type: :view do
  before(:each) do
    @merchant1 = Merchant.create!(name: "Target", status: 0)
    @merchant2 = Merchant.create!(name: "Walmart", status: 0)
    @merchant3 = Merchant.create!(name: "Gamestop", status: 1)
  end

  it "can create a new merchant" do
    visit admin_merchants_path

    within ("#disabled_merchants") do
      expect(page).to_not have_content("Blockbuster")
    end

    click_link "New Merchant"

    expect(current_path).to eq(new_admin_merchant_path)

    fill_in "Name", with: "Blockbuster"
    click_button "Submit"

    expect(current_path).to eq admin_merchants_path

    within ("#disabled_merchants") do
      expect(page).to have_content("Blockbuster")
    end

    expect(page).to have_content("Merchant Successfully Created!")
  end
end