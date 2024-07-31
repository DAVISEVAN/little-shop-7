

require 'rails_helper'

RSpec.describe 'Merchant Dashboard', type: :feature do
  before(:each) do
    @merchant = Merchant.create!(name: "Test Merchant")

    @item1 = @merchant.items.create!(name: "Item 1", description: "Description 1", unit_price: 100, status: :enabled)
    @item2 = @merchant.items.create!(name: "Item 2", description: "Description 2", unit_price: 200, status: :enabled)

    @customer1 = Customer.create!(first_name: "John", last_name: "Doe")
    @customer2 = Customer.create!(first_name: "Jane", last_name: "Smith")
    @customer3 = Customer.create!(first_name: "Alice", last_name: "Johnson")
    @customer4 = Customer.create!(first_name: "Bob", last_name: "Brown")
    @customer5 = Customer.create!(first_name: "Charlie", last_name: "Davis")
    @customer6 = Customer.create!(first_name: "Dana", last_name: "White")

    @invoice1 = Invoice.create!(status: 0, customer: @customer1, created_at: "2023-07-18")
    @invoice2 = Invoice.create!(status: 0, customer: @customer2, created_at: "2023-07-19")
    @invoice3 = Invoice.create!(status: 0, customer: @customer3, created_at: "2023-07-20")
    @invoice4 = Invoice.create!(status: 0, customer: @customer4, created_at: "2023-07-21")
    @invoice5 = Invoice.create!(status: 0, customer: @customer5, created_at: "2023-07-22")
    @invoice6 = Invoice.create!(status: 0, customer: @customer6, created_at: "2023-07-23")

    @invoice_item1 = InvoiceItem.create!(quantity: 5, unit_price: 100, item: @item1, invoice: @invoice1, status: 0)
    @invoice_item2 = InvoiceItem.create!(quantity: 3, unit_price: 200, item: @item2, invoice: @invoice2, status: 0)
    @invoice_item3 = InvoiceItem.create!(quantity: 4, unit_price: 150, item: @item1, invoice: @invoice3, status: 0)
    @invoice_item4 = InvoiceItem.create!(quantity: 2, unit_price: 250, item: @item2, invoice: @invoice4, status: 0)
    @invoice_item5 = InvoiceItem.create!(quantity: 6, unit_price: 120, item: @item1, invoice: @invoice5, status: 0)
    @invoice_item6 = InvoiceItem.create!(quantity: 1, unit_price: 300, item: @item2, invoice: @invoice6, status: 0)

    @transaction1 = Transaction.create!(credit_card_number: "1234567812345678", credit_card_expiration_date: "04/25", result: 0, invoice: @invoice1)
    @transaction2 = Transaction.create!(credit_card_number: "1234567812345678", credit_card_expiration_date: "04/25", result: 0, invoice: @invoice2)
    @transaction3 = Transaction.create!(credit_card_number: "1234567812345678", credit_card_expiration_date: "04/25", result: 0, invoice: @invoice3)
    @transaction4 = Transaction.create!(credit_card_number: "1234567812345678", credit_card_expiration_date: "04/25", result: 0, invoice: @invoice4)
    @transaction5 = Transaction.create!(credit_card_number: "1234567812345678", credit_card_expiration_date: "04/25", result: 0, invoice: @invoice5)
    @transaction6 = Transaction.create!(credit_card_number: "1234567812345678", credit_card_expiration_date: "04/25", result: 0, invoice: @invoice6)
  end
# User Story 1, Merchant Dashboard displays merchant name 
  it 'displays the name of the merchant' do
    visit merchant_dashboard_path(@merchant)

    expect(page).to have_content(@merchant.name)
  end
# User Story 2, Merchant Dashboard links to merchant items and invoices index
  it 'displays a link to the merchant items index' do
    visit merchant_dashboard_path(@merchant)

    expect(page).to have_link('Items Index', href: merchant_items_path(@merchant))
  end

    expect(page).to have_link('Invoices Index', href: merchant_invoices_path(@merchant))
  end
# User Story 3, Merchant Dashboard displays top 5 customers with successful transactions
  it 'displays the top 5 customers with the largest number of successful transactions' do
    visit merchant_dashboard_path(@merchant)

    within('#top-customers') do
      [@customer1, @customer2, @customer3, @customer4, @customer5].each do |customer|
        expect(page).to have_content("#{customer.first_name} #{customer.last_name}")
      end
    end
  end
# User Story 4, Merchant Dashboard displays items ready to ship
# User Story 5, Merchant Dashboard displays date next to each item ready to ship
  it 'displays items ready to ship with invoice details' do
    visit merchant_dashboard_path(@merchant)

      within('#ready-to-ship-items') do
      expect(page).to have_content(@item1.name)
      expect(page).to have_content("Invoice ID: #{@invoice1.id}")
      expect(page).to have_content(@item2.name)
      expect(page).to have_content("Invoice ID: #{@invoice2.id}")
    
      date_regex = /\b(Monday|Tuesday|Wednesday|Thursday|Friday|Saturday|Sunday), (January|February|March|April|May|June|July|August|September|October|November|December) \d{1,2}, \d{4}\b/
      expect(page).to have_content(date_regex)
    end
    
  end
end
