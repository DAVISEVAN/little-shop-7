require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'associations' do
    it { should have_many(:items) }
    it { should have_many(:invoices).through(:items) }
  end

  describe 'methods' do
    before :each do
      @merchant = Merchant.create!(name: "Test Merchant")

      @item1 = Item.create!(name: "Item 1", description: "Description 1", unit_price: 100, merchant: @merchant)
      @item2 = Item.create!(name: "Item 2", description: "Description 2", unit_price: 200, merchant: @merchant)

      @customer1 = Customer.create!(first_name: "John", last_name: "Doe")
      @customer2 = Customer.create!(first_name: "Jane", last_name: "Smith")
      @customer3 = Customer.create!(first_name: "Alice", last_name: "Johnson")
      @customer4 = Customer.create!(first_name: "Bob", last_name: "Brown")
      @customer5 = Customer.create!(first_name: "Charlie", last_name: "Davis")
      @customer6 = Customer.create!(first_name: "Dana", last_name: "White")

      @invoice1 = Invoice.create!(status: 0, customer: @customer1)
      @invoice2 = Invoice.create!(status: 1, customer: @customer2)
      @invoice3 = Invoice.create!(status: 0, customer: @customer3)
      @invoice4 = Invoice.create!(status: 1, customer: @customer4)
      @invoice5 = Invoice.create!(status: 0, customer: @customer5)
      @invoice6 = Invoice.create!(status: 1, customer: @customer6)

      InvoiceItem.create!(quantity: 5, unit_price: 100, item: @item1, invoice: @invoice1)
      InvoiceItem.create!(quantity: 3, unit_price: 200, item: @item2, invoice: @invoice2)
      InvoiceItem.create!(quantity: 4, unit_price: 150, item: @item1, invoice: @invoice3)
      InvoiceItem.create!(quantity: 2, unit_price: 250, item: @item2, invoice: @invoice4)
      InvoiceItem.create!(quantity: 6, unit_price: 120, item: @item1, invoice: @invoice5)
      InvoiceItem.create!(quantity: 1, unit_price: 300, item: @item2, invoice: @invoice6)

      Transaction.create!(credit_card_number: "1234567812345678", credit_card_expiration_date: "04/25", result: 0, invoice: @invoice1)
      Transaction.create!(credit_card_number: "1234567812345678", credit_card_expiration_date: "04/25", result: 0, invoice: @invoice2)
      Transaction.create!(credit_card_number: "1234567812345678", credit_card_expiration_date: "04/25", result: 0, invoice: @invoice3)
      Transaction.create!(credit_card_number: "1234567812345678", credit_card_expiration_date: "04/25", result: 0, invoice: @invoice4)
      Transaction.create!(credit_card_number: "1234567812345678", credit_card_expiration_date: "04/25", result: 0, invoice: @invoice5)
      Transaction.create!(credit_card_number: "1234567812345678", credit_card_expiration_date: "04/25", result: 0, invoice: @invoice6)
    end

    # User Story 3, Top 5 Customers
    it 'returns the top 5 customers with the largest number of successful transactions' do
      top_customers = @merchant.top_customers

      expect(@merchant.top_customers).to eq([@customer1, @customer2, @customer3, @customer4, @customer5])
      expect(top_customers.first.transaction_count).to eq(1) #Since each customer has 1 successful transaction
    end
  end
end
