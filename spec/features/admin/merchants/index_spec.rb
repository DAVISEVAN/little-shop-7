require 'rails_helper'

RSpec.describe "merchant index", type: :view do
  before(:each) do
    @merchant1 = Merchant.create!(name: "Target")
    @merchant2 = Merchant.create!(name: "Walmart")
    @merchant3 = Merchant.create!(name: "Gamestop")
  end

  it 'shows the name of each merchant in the system' do
    visit admin_merchants_path

    expect(page).to have_content(@merchant1.name)
    expect(page).to have_content(@merchant2.name)
    expect(page).to have_content(@merchant3.name)
  end

  it "has a button to update each merchant's status" do
    visit admin_merchants_path

    within("#merchant-#{@merchant1.id}") do
      click_button "Disable"
    end

    @merchant1.reload
    expect(current_path).to eq admin_merchants_path

    within("#merchant-#{@merchant1.id}") do
      expect(page).to have_button("Enable")
    end
  end
end
