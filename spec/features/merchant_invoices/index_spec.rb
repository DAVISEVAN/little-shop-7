require 'rails_helper'

RSpec.describe 'Merchant Invoices Index', type: :feature do
  before :each do
    @merchant = create(:merchant)
    @items = create_list(:item, 5, merchant: @merchant)
    @invoices = @items.map do |item|
      invoice = create(:invoice, customer: create(:customer))
      create(:invoice_item, invoice: invoice, item: item)
      invoice
    end

    visit merchant_invoices_path(@merchant)
  end

  it 'displays a list of invoices for the merchant' do
    @invoices.each do |invoice|
      expect(page).to have_content(invoice.id)
    end
  end
end
