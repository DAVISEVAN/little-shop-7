require 'rails_helper'

RSpec.describe "merchants/index.html.erb", type: :view do
  before(:each) do
    @merchant1 = Merchant.create!(name: "Target")
    @merchant2 = Merchant.create!(name: "Walmart")
    @merchant3 = Merchant.create!(name: "Gamestop")
  end

    it 'shows the name of each merchant in the system' do
      visit admin_merchants_path(@merchants)

      expect(page).to have_content(@merchant1.name)
      expect(page).to have_content(@merchant2.name)
      expect(page).to have_content(@merchant3.name)
  end
end
