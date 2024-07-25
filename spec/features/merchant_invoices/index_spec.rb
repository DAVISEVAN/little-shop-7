require 'rails_helper'

RSpec.describe 'Merchant Invoices Index', type: :feature do
  before :each do
    @merchant = Merchant.create!(name: "Test Merchant")

    @item1 = Item.create!(name: "Item 1", description: "Description 1", unit_price: 100, merchant: @merchant)
    @item2 = Item.create!(name: "Item 2", description: "Description 2", unit_price: 200, merchant: @merchant)

    @customer1 = Customer.create!(first_name: "John", last_name: "Doe")
    @customer2 = Customer.create!(first_name: "Jane", last_name: "Smith")

    @invoice1 = Invoice.create!(status: 0, customer: @customer1)
    @invoice2 = Invoice.create!(status: 1, customer: @customer2)

    InvoiceItem.create!(quantity: 5, unit_price: 100, item: @item1, invoice: @invoice1)
    InvoiceItem.create!(quantity: 3, unit_price: 200, item: @item2, invoice: @invoice2)

    Transaction.create!(credit_card_number: "1234567812345678", credit_card_expiration_date: "04/25", result: 0, invoice: @invoice1)
    Transaction.create!(credit_card_number: "1234567812345678", credit_card_expiration_date: "04/25", result: 0, invoice: @invoice2)
  end

  it 'displays a list of invoices for the merchant' do
    visit merchant_invoices_path(@merchant)

    @merchant.invoices.each do |invoice|
      expect(page).to have_content(invoice.id)
    end
  end
end
