require 'rails_helper'

RSpec.describe 'Merchant Dashboard', type: :feature do
  before :each do
    @merchant = FactoryBot.create(:merchant)
  end

  it 'displays the name of the merchant' do
    visit merchant_dashboard_path(@merchant)

    within('h1') do
      expect(page).to have_content(@merchant.name)
    end
  end
end