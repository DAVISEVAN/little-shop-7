require 'rails_helper'
include ActionView::Helpers::NumberHelper

RSpec.describe 'Merchant Invoices Show Page', type: :feature do
  include ApplicationHelper

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

  # User Story 15, Invoice Show Page
  it 'displays the correct header' do
    visit merchant_invoice_path(@merchant, @invoice1)

    expect(page).to have_content(@invoice1.customer.first_name)
    expect(page).to have_content("Invoice For: John Doe")
    
    expect(current_path).to eq(merchant_invoice_path(@merchant, @invoice1))
  end

  # User Story 15, Merchant Invoice Show Page: Invoice Info
  it 'has the correct #invoice-info' do
    visit merchant_invoice_path(@merchant, @invoice1)

    within("#invoice-info") do
      expect(page).to have_content("Invoice ID: #{@invoice1.id}")
      expect(page).to have_content("Invoice Date: #{@invoice1.created_at.strftime("%A, %B %d, %Y")}")
      expect(page).to have_content("Invoice Status: #{@invoice1.status}")
      expect(page).to have_content("John Doe")
    end
  end

  # User Story 16, Merchant Invoice Show Page: Invoice Item Information
  it 'has the correct #invoice-items' do
    visit merchant_invoice_path(@merchant, @invoice1)

    within("#invoice-items") do
      @invoice1.invoice_items.each do |invoice_item|
        expect(page).to have_content(invoice_item.item.name)
        expect(page).to have_content(invoice_item.quantity)
        expect(page).to have_content(cents_to_dollars(invoice_item.unit_price))
        expect(page).to have_content(invoice_item.status)
      end
    end
  end

  # User Story 17, Merchant Invoice Show Page: Total Revenue
  it 'has the correct total revenue' do
    visit merchant_invoice_path(@merchant, @invoice1)

    within("#invoice-items") do
      expect(page).to have_content("Total Revenue: #{cents_to_dollars(@invoice1.total_revenue)}")
    end
  end

  # User Story 18, Merchant Invoice Show Page: Update Invoice Item Status
  it 'allows the merchant to update the invoice item status' do
    visit merchant_invoice_path(@merchant, @invoice1)

    save_and_open_page

    within("#invoice_item_status_update_#{@invoice_item1.id}") do
      
      
      select 'shipped', from: 'status'
      click_button 'Update Item Status'
      @invoice_item1.reload
    end
  # Save and open page for manual inspection
      

    expect(current_path).to eq(merchant_invoice_path(@merchant, @invoice1))
    within("#invoice_item_status_update_#{@invoice_item1.id}") do
      expect(page).to have_select('status', selected: 'shipped')
    end
  end
end
