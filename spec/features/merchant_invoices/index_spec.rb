require 'rails_helper'
# User Story 2, Merchant Invoices Index
RSpec.describe 'Merchant Invoices Index', type: :feature do
  before :each do
    @merchant = FactoryBot.create(:merchant)
    @invoices = FactoryBot.create_list(:invoice, 5, merchant: @merchant)
  end

  it 'displays a list of invoices for the merchant' do
    visit merchant_invoices_path(@merchant)

    save_and_open_page # Debugging line to open the rendered HTML

    @invoices.each do |invoice|
      within('ul') do
        expect(page).to have_content("Invoice ID: #{invoice.id}")
      end
    end
  end
end
