require 'rails_helper'

RSpec.describe 'Merchant Dashboard', type: :feature do
  before :each do
    @merchant = FactoryBot.create(:merchant)
    @items = FactoryBot.create_list(:item, 5, merchant: @merchant)
    @invoices = FactoryBot.create_list(:invoice, 5, merchant: @merchant)
  end
  # User Story 1, Merchant Dashboard
  it 'displays the name of the merchant' do
    visit merchant_dashboard_path(@merchant)

    within('h1') do
      expect(page).to have_content(@merchant.name)
    end
  end
  # User Story 2, Merchant Items Index Link
  it 'displays a link to the merchant items index' do
    visit merchant_dashboard_path(@merchant)

    within('nav') do
      expect(page).to have_link('Items Index', href: merchant_items_path(@merchant))
    end
  end

  it 'displays a link to the merchant invoices index' do
    visit merchant_dashboard_path(@merchant)

    within('nav') do
      expect(page).to have_link('Invoices Index', href: merchant_invoices_path(@merchant))
    end
  end
end
