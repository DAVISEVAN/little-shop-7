# spec/models/merchant_spec.rb
require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'associations' do
    it { should have_many(:items) }
    it { should have_many(:invoice_items).through(:items) }
    it { should have_many(:invoices).through(:invoice_items) }
  end

  describe 'methods' do
    before(:each) do
      @merchant = Merchant.create!(name: "Test Merchant")

      @item1 = @merchant.items.create!(name: "Item 1", description: "Description 1", unit_price: 100, status: :enabled)
      @item2 = @merchant.items.create!(name: "Item 2", description: "Description 2", unit_price: 200, status: :enabled)

      @customer = Customer.create!(first_name: "John", last_name: "Doe")
      @invoice1 = Invoice.create!(status: 0, customer: @customer, created_at: "2023-07-18")
      @invoice2 = Invoice.create!(status: 0, customer: @customer, created_at: "2023-07-19")

      @invoice_item1 = InvoiceItem.create!(quantity: 5, unit_price: 100, item: @item1, invoice: @invoice1, status: 0)
      @invoice_item2 = InvoiceItem.create!(quantity: 3, unit_price: 200, item: @item2, invoice: @invoice2, status: 0)

      @transaction1 = Transaction.create!(credit_card_number: "1234567812345678", credit_card_expiration_date: "04/25", result: 0, invoice: @invoice1)
      @transaction2 = Transaction.create!(credit_card_number: "1234567812345678", credit_card_expiration_date: "04/25", result: 0, invoice: @invoice2)
    end

    it 'returns the top 5 customers with the largest number of successful transactions' do
      expect(@merchant.top_customers).to eq([@customer])
    end

    it 'lists all items ready to ship' do
      items_ready_to_ship = @merchant.items_ready_to_ship.map(&:id)
      expect(items_ready_to_ship).to include(@item1.id, @item2.id)
    end

    it 'lists items ready to ship in order from oldest to newest' do
      items_ready_to_ship = @merchant.items_ready_to_ship.order('invoice_items.created_at ASC').map(&:id)
      expect(items_ready_to_ship).to eq([@item1.id, @item2.id])
    end
  end
end


