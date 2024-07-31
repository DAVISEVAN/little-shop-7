require "rails_helper"

RSpec.describe Merchant, type: :model do
  describe "relationships" do
    it { should have_many :items }
    it { should have_many(:invoices).through(:items) }
  end

  describe "#best_day" do
  let (:merchant) { create(:merchant) }
  let (:actual){merchant.best_day}
    context "when their is only 1 day" do
      before(:each) do
        @item1 = Item.create!(name: "Milk", description: "2%", unit_price: 400, merchant_id: merchant.id)
        @item2 = Item.create!(name: "Beer", description: "IPA", unit_price: 1000, merchant_id: merchant.id)
      
        @customer1 = Customer.create!(first_name: "Bob", last_name: "The Builder")
        @customer2 = Customer.create!(first_name: "Ted", last_name: "Bear")
      
        @invoice1 = Invoice.create!(status: 1, customer_id: @customer1.id) # 4
        #@invoice2 = Invoice.create!(status: 1, customer_id: @customer1.id) # 2
    
        InvoiceItem.create!(quantity: 2, unit_price: 500, item_id: @item1.id, invoice_id: @invoice1.id, status: 0)
        # InvoiceItem.create!(quantity: 3, unit_price: 500, item_id: @item2.id, invoice_id: @invoice2.id, status: 1)
      end
      it "should return that day" do
        expected = @invoice1.created_at
        expect(actual).to eq(expected)
      end
    end

    context "when their is 2 days with same amount" do
      before(:each) do
        @item1 = Item.create!(name: "Milk", description: "2%", unit_price: 400, merchant_id: merchant.id)
        @item2 = Item.create!(name: "Beer", description: "IPA", unit_price: 1000, merchant_id: merchant.id)
      
        @customer1 = Customer.create!(first_name: "Bob", last_name: "The Builder")
        @customer2 = Customer.create!(first_name: "Ted", last_name: "Bear")
      
        @invoice1 = Invoice.create!(status: 1, customer_id: @customer1.id, created_at: 1.week.ago) # 4
        @invoice2 = Invoice.create!(status: 1, customer_id: @customer1.id, created_at: 2.week.ago) # 2
    
        InvoiceItem.create!(quantity: 3, unit_price: 500, item_id: @item1.id, invoice_id: @invoice1.id, status: 0)
        InvoiceItem.create!(quantity: 3, unit_price: 500, item_id: @item2.id, invoice_id: @invoice2.id, status: 1)
      end
      it "should return the most recent day" do
        expected = @invoice1.created_at
        expect(actual).to eq(expected)
      end
    end

    context "when their is a day with a higher sale amount" do
      before(:each) do
        @item1 = Item.create!(name: "Milk", description: "2%", unit_price: 400, merchant_id: merchant.id)
        @item2 = Item.create!(name: "Beer", description: "IPA", unit_price: 1000, merchant_id: merchant.id)
      
        @customer1 = Customer.create!(first_name: "Bob", last_name: "The Builder")
        @customer2 = Customer.create!(first_name: "Ted", last_name: "Bear")
      
        @invoice1 = Invoice.create!(status: 1, customer_id: @customer1.id, created_at: 2.week.ago) # 4
        @invoice2 = Invoice.create!(status: 1, customer_id: @customer1.id, created_at: 1.week.ago) # 2
    
        InvoiceItem.create!(quantity: 2, unit_price: 500, item_id: @item1.id, invoice_id: @invoice1.id, status: 0)
        InvoiceItem.create!(quantity: 3, unit_price: 500, item_id: @item2.id, invoice_id: @invoice2.id, status: 1)
      end
      it "should return the highest sale day" do
        expected = @invoice2.created_at
        expect(actual).to eq(expected)
      end
    end

    context "when their is 0 sales" do
      it "should return an empty string" do
        expected = ""
        expect(actual).to eq(expected)
      end
    end
  end
end