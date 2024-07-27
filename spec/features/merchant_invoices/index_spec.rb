require 'rails_helper'

RSpec.describe 'Merchant Invoices Index', type: :feature do
  before :each do
    @merchant = Merchant.create!(name: 'Test Merchant')
    @customer = Customer.create!(first_name: 'John', last_name: 'Doe')
    @invoice = Invoice.create!(status: 0, customer: @customer)
    InvoiceItem.create!(quantity: 5, unit_price: 100, item: @merchant.items.create!(name: 'Item 1', description: 'Description 1', unit_price: 100), invoice: @invoice)
    Transaction.create!(credit_card_number: '1234567812345678', credit_card_expiration_date: '04/25', result: 'success', invoice: @invoice)
  end

  # User Story 5
  it 'displays a list of invoices for the merchant' do
    visit merchant_invoices_path(@merchant)

    expect(page).to have_link("Invoice ID: #{@invoice.id}", href: merchant_invoice_path(@merchant, @invoice))
  end
end
