require 'rails_helper'

RSpec.describe "merchants/show.html.erb", type: :view do
  before(:each) do
    @merchant1 = Merchant.create!(name: "Target")
    @merchant2 = Merchant.create!(name: "Walmart")
    @merchant3 = Merchant.create!(name: "Gamestop")
  end

  it "displays the name of the merchant" do
    visit admin_merchant_path(@merchant1)

    expect(page).to have_content(@merchant1.name)
  end

end