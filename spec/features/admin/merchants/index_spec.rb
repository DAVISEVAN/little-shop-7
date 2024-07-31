require 'rails_helper'

RSpec.describe "merchant index", type: :view do
  before(:each) do
    @merchant1 = Merchant.create!(name: "Target", status: 0)
    @merchant2 = Merchant.create!(name: "Walmart", status: 0)
    @merchant3 = Merchant.create!(name: "Gamestop", status: 1)
  end

  it 'shows the name of each merchant in the system in disabled or enabled sections' do
    visit admin_merchants_path

    within("#enabled_merchants") do
      expect(page).to have_content(@merchant1.name)
      expect(page).to have_content(@merchant2.name)
      expect(page).to_not have_content(@merchant3.name)
    end

    within("#disabled_merchants") do
      expect(page).to_not have_content(@merchant1.name)
      expect(page).to_not have_content(@merchant2.name)
      expect(page).to have_content(@merchant3.name)
    end
  end

  it "has a functional button to update each merchant's status to 'enabled' or 'disabled'" do
    visit admin_merchants_path

    within("#merchant-#{@merchant1.id}") do
      click_button "Disable"
    end

    expect(current_path).to eq admin_merchants_path

    within("#merchant-#{@merchant1.id}") do
      expect(page).to have_button("Enable")
    end

    within("#merchant-#{@merchant3.id}") do
      click_button "Enable"
    end

    expect(current_path).to eq admin_merchants_path

    within("#merchant-#{@merchant3.id}") do
      expect(page).to have_button("Disable")
    end
  end
end
