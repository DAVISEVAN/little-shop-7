# Usery Story 12, Top Items by Total Revenue

require 'rails_helper'

RSpec.describe 'Merchant Items Index', type: :feature do
  describe 'top 5 items by total revenue' do
    before(:each) do
      @merchant = Merchant.create!(name: "Test Merchant")
      @item1 = @merchant.items.create!(name: "Item 1", description: "Description 1", unit_price: 10000) # $100.00
      @item2 = @merchant.items.create!(name: "Item 2", description: "Description 2", unit_price: 20000) # $200.00
      @item3 = @merchant.items.create!(name: "Item 3", description: "Description 3", unit_price: 30000) # $300.00
      @item4 = @merchant.items.create!(name: "Item 4", description: "Description 4", unit_price: 40000) # $400.00
      @item5 = @merchant.items.create!(name: "Item 5", description: "Description 5", unit_price: 50000) # $500.00
      @item6 = @merchant.items.create!(name: "Item 6", description: "Description 6", unit_price: 60000) # $600.00

      @customer = Customer.create!(first_name: "Customer", last_name: "One")

      @invoice1 = Invoice.create!(status: "completed", customer: @customer)
      @invoice2 = Invoice.create!(status: "completed", customer: @customer)
      @invoice3 = Invoice.create!(status: "completed", customer: @customer)
      @invoice4 = Invoice.create!(status: "completed", customer: @customer)
      @invoice5 = Invoice.create!(status: "completed", customer: @customer)

      InvoiceItem.create!(invoice: @invoice1, item: @item1, quantity: 10, unit_price: 5000) # $500.00
      InvoiceItem.create!(invoice: @invoice2, item: @item2, quantity: 20, unit_price: 3000) # $600.00
      InvoiceItem.create!(invoice: @invoice3, item: @item3, quantity: 30, unit_price: 1000) # $300.00
      InvoiceItem.create!(invoice: @invoice4, item: @item4, quantity: 4, unit_price: 4000) # $160.00
      InvoiceItem.create!(invoice: @invoice5, item: @item5, quantity: 4, unit_price: 2000) # $80.00

      Transaction.create!(invoice: @invoice1, credit_card_number: "1234567890123456", result: :success)
      Transaction.create!(invoice: @invoice2, credit_card_number: "1234567890123456", result: :success)
      Transaction.create!(invoice: @invoice3, credit_card_number: "1234567890123456", result: :success)
      Transaction.create!(invoice: @invoice4, credit_card_number: "1234567890123456", result: :success)
      Transaction.create!(invoice: @invoice5, credit_card_number: "1234567890123456", result: :success)

      visit merchant_items_path(@merchant)
    end

    it 'displays the top 5 items by total revenue' do
      within('#top-items') do
        expect(page).to have_link(@item1.name, href: merchant_item_path(@merchant, @item1))
        expect(page).to have_link(@item2.name, href: merchant_item_path(@merchant, @item2))
        expect(page).to have_link(@item3.name, href: merchant_item_path(@merchant, @item3))
        expect(page).to have_link(@item4.name, href: merchant_item_path(@merchant, @item4))
        expect(page).to have_link(@item5.name, href: merchant_item_path(@merchant, @item5))
        expect(page).to have_content("$600.00")
        expect(page).to have_content("$500.00")
        expect(page).to have_content("$300.00")
        expect(page).to have_content("$160.00")
        expect(page).to have_content("$80.00")
      end
    end
  end
end
