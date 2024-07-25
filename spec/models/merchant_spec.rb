require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'associations' do
    it { should have_many(:items) }
    it { should have_many(:invoice_items).through(:items) }
    it { should have_many(:invoices).through(:invoice_items) }
    it { should have_many(:customers).through(:invoices) }
  end

  describe 'methods' do
    before :each do
      @merchant = create(:merchant)
      @customers = create_list(:customer, 6)

      @customers.each do |customer|
        invoice = create(:invoice, customer: customer)
        item = create(:item, merchant: @merchant)
        create(:invoice_item, invoice: invoice, item: item)
        create_list(:transaction, 3, result: 'success', invoice: invoice)
      end
    end

    it 'returns the top 5 customers with the largest number of successful transactions' do
      top_customers = @merchant.top_customers

      expect(top_customers.count).to eq(5)
      expect(top_customers.first.transactions_count).to eq(3)
    end
  end
end
