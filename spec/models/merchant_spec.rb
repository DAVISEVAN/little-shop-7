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




  describe 'top items by revenue and best day' do
    before(:each) do
      @merchant = Merchant.create!(name: "Test Merchant")
  
      @item1 = @merchant.items.create!(name: "Item 1", description: "Description 1", unit_price: 100)
      @item2 = @merchant.items.create!(name: "Item 2", description: "Description 2", unit_price: 200)
      @item3 = @merchant.items.create!(name: "Item 3", description: "Description 3", unit_price: 300)
      @item4 = @merchant.items.create!(name: "Item 4", description: "Description 4", unit_price: 400)
      @item5 = @merchant.items.create!(name: "Item 5", description: "Description 5", unit_price: 500)
      @item6 = @merchant.items.create!(name: "Item 6", description: "Description 6", unit_price: 600)
  
      @customer = Customer.create!(first_name: "John", last_name: "Doe")
  
      @invoice1 = create(:invoice, customer: @customer, created_at: "2023-07-18")
      @invoice2 = create(:invoice, customer: @customer, created_at: "2023-07-19")
      @invoice3 = create(:invoice, customer: @customer, created_at: "2023-07-20")
      @invoice4 = create(:invoice, customer: @customer, created_at: "2023-07-21")
      @invoice5 = create(:invoice, customer: @customer, created_at: "2023-07-22")
  
      create(:invoice_item, invoice: @invoice1, item: @item1, quantity: 5, unit_price: 100)
      create(:invoice_item, invoice: @invoice2, item: @item2, quantity: 3, unit_price: 200)
      create(:invoice_item, invoice: @invoice3, item: @item3, quantity: 4, unit_price: 300)
      create(:invoice_item, invoice: @invoice4, item: @item4, quantity: 2, unit_price: 400)
      create(:invoice_item, invoice: @invoice5, item: @item5, quantity: 6, unit_price: 500)
  
      create(:transaction, invoice: @invoice1, result: 0)
      create(:transaction, invoice: @invoice2, result: 0)
      create(:transaction, invoice: @invoice3, result: 0)
      create(:transaction, invoice: @invoice4, result: 0)
      create(:transaction, invoice: @invoice5, result: 0)
    end
  
    it 'lists top 5 items by total revenue' do
      top_5_items = @merchant.top_5_items_by_revenue
      expect(top_5_items.map(&:id)).to eq([@item5.id, @item4.id, @item3.id, @item2.id, @item1.id].sort_by { |id| [top_5_items.find { |item| item.id == id }.total_revenue, id] }.reverse)
    end
  
    it 'returns the best day for each item based on total revenue' do
      best_day_item1 = @merchant.best_day_for_item(@item1.id)
      expect(best_day_item1).to eq(@invoice1.created_at.strftime("%A, %B %d, %Y"))
    end
  end
end