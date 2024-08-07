require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe 'relationships' do
    it { should belong_to :customer }
    it { should have_many :transactions }
    it { should have_many :invoice_items }
    it { should have_many(:items).through(:invoice_items) }
    it { should have_many(:merchants).through(:items) }
    it { should belong_to(:coupon).optional }
  end

  describe 'validations' do
    it { should define_enum_for(:status).with_values([:"in progress", :completed, :cancelled]) }
  end

  before(:each) do
    @merchant1 = Merchant.create!(name: "Target")
    @merchant2 = Merchant.create!(name: "Walmart")
    @merchant3 = Merchant.create!(name: "Gamestop")
  
    @item1 = Item.create!(name: "Milk", description: "2%", unit_price: 400, merchant_id: @merchant1.id)
    @item2 = Item.create!(name: "Beer", description: "IPA", unit_price: 1000, merchant_id: @merchant1.id)
    @item3 = Item.create!(name: "Crackers", description: "Salty Bois", unit_price: 800, merchant_id: @merchant2.id)
    @item4 = Item.create!(name: "Oil", description: "For ya car", unit_price: 15000, merchant_id: @merchant2.id)
    @item5 = Item.create!(name: "Halo", description: "Timeless classic", unit_price: 40000, merchant_id: @merchant3.id)
    @item6 = Item.create!(name: "COD", description: "Its a game!", unit_price: 50000, merchant_id: @merchant3.id)
  
    @customer1 = Customer.create!(first_name: "Bob", last_name: "The Builder")
    @customer2 = Customer.create!(first_name: "Ted", last_name: "Bear")
  
    @invoice1 = Invoice.create!(status: 1, customer_id: @customer1.id) # 4
    @invoice2 = Invoice.create!(status: 1, customer_id: @customer1.id) # 2
    @invoice3 = Invoice.create!(status: 1, customer_id: @customer2.id)
    @invoice4 = Invoice.create!(status: 1, customer_id: @customer1.id) # 3
    @invoice5 = Invoice.create!(status: 1, customer_id: @customer1.id) # 1
    @invoice6 = Invoice.create!(status: 1, customer_id: @customer2.id)

    InvoiceItem.create!(quantity: 2, unit_price: 500, item_id: @item1.id, invoice_id: @invoice1.id, status: 0)
    InvoiceItem.create!(quantity: 3, unit_price: 500, item_id: @item2.id, invoice_id: @invoice2.id, status: 1)
    InvoiceItem.create!(quantity: 1, unit_price: 500, item_id: @item3.id, invoice_id: @invoice3.id, status: 2)
    InvoiceItem.create!(quantity: 4, unit_price: 500, item_id: @item4.id, invoice_id: @invoice4.id, status: 0)
    InvoiceItem.create!(quantity: 3, unit_price: 500, item_id: @item5.id, invoice_id: @invoice5.id, status: 1)
    InvoiceItem.create!(quantity: 2, unit_price: 500, item_id: @item6.id, invoice_id: @invoice6.id, status: 2)
  end

  describe 'instance methods' do
    it 'customer_full_name' do
      expect(@invoice1.customer_full_name).to eq(@customer1.first_name + " " + @customer1.last_name)
      expect(@invoice2.customer_full_name).to eq(@customer1.first_name + " " + @customer1.last_name)
      expect(@invoice3.customer_full_name).to eq(@customer2.first_name + " " + @customer2.last_name)
    end

    it 'should calculate the total revenue for the invoice' do
      expect(@invoice1.total_revenue).to eq(1000)
      expect(@invoice2.total_revenue).to eq(1500)
      expect(@invoice3.total_revenue).to eq(500)
    end

    it 'calculates total revenue with multiple invoice items' do
      invoice = Invoice.create!(status: 1, customer_id: @customer1.id)
      InvoiceItem.create!(quantity: 5, unit_price: 1000, item_id: @item1.id, invoice_id: invoice.id, status: 0) # $50.00
      InvoiceItem.create!(quantity: 3, unit_price: 2000, item_id: @item2.id, invoice_id: invoice.id, status: 1) # $60.00
      expect(invoice.total_revenue).to eq(11000) # $50.00 + $60.00 = $110.00 (11000 cents)
    end
    
    it 'calculates total revenue with different quantities and unit prices' do
      invoice = Invoice.create!(status: 1, customer_id: @customer1.id)
      InvoiceItem.create!(quantity: 10, unit_price: 100, item_id: @item1.id, invoice_id: invoice.id, status: 0) # $10.00
      InvoiceItem.create!(quantity: 20, unit_price: 50, item_id: @item2.id, invoice_id: invoice.id, status: 1) # $10.00
      expect(invoice.total_revenue).to eq(2000) # $10.00 + $10.00 = $20.00 (2000 cents)
    end
  end

  describe 'class methods' do
    it 'self.incomplete_invoices' do
      expect(Invoice.incomplete_invoices).to eq([@invoice1, @invoice2, @invoice4, @invoice5])
    end
  end

  describe 'instance methods' do
    before :each do
      @merchant1 = create(:merchant)
      @merchant2 = create(:merchant)
      @customer = create(:customer)
      @coupon = create(:coupon, merchant: @merchant1, discount_type: 'percent', amount: 10)
      @invoice = create(:invoice, customer: @customer, coupon: @coupon, status: 'completed')
      @item1 = create(:item, merchant: @merchant1)
      @item2 = create(:item, merchant: @merchant2)
      @invoice_item1 = create(:invoice_item, invoice: @invoice, item: @item1, quantity: 2, unit_price: 1000) # $20.00 total
      @invoice_item2 = create(:invoice_item, invoice: @invoice, item: @item2, quantity: 1, unit_price: 2000) # $20.00 total
    end

    describe '#admin_subtotal' do
      it 'calculates the subtotal for the entire invoice' do
        expect(@invoice.admin_subtotal).to eq(4000) # $40.00 total
      end
    end

    describe '#admin_grand_total' do
      it 'calculates the grand total for the entire invoice with a percent discount' do
        expect(@invoice.admin_grand_total).to eq(3800) # $40.00 - 10% of $20.00 (only items from merchant1)
      end

      it 'calculates the grand total for the entire invoice with a dollar discount' do
        @coupon.update(discount_type: 'dollar', amount: 500)
        expect(@invoice.admin_grand_total).to eq(3500) # $40.00 - $5.00
      end

      it 'does not apply discount to the grand total if no coupon' do
        @invoice.update(coupon: nil)
        expect(@invoice.admin_grand_total).to eq(4000) # $40.00 total
      end
    end

    describe '#subtotal' do
      it 'calculates the subtotal for the merchant' do
        expect(@invoice.subtotal(@merchant1)).to eq(2000) # $20.00 total for merchant1
        expect(@invoice.subtotal(@merchant2)).to eq(2000) # $20.00 total for merchant2
      end
    end

    describe '#grand_total' do
      it 'calculates the grand total for the merchant with a percent discount' do
        expect(@invoice.grand_total(@merchant1)).to eq(1800) # $20.00 - 10% of $20.00 for merchant1
        expect(@invoice.grand_total(@merchant2)).to eq(2000) # $20.00 total for merchant2 (no discount)
      end

      it 'calculates the grand total for the merchant with a dollar discount' do
        @coupon.update(discount_type: 'dollar', amount: 500)
        expect(@invoice.grand_total(@merchant1)).to eq(1500) # $20.00 - $5.00 for merchant1
        expect(@invoice.grand_total(@merchant2)).to eq(2000) # $20.00 total for merchant2 (no discount)
      end

      it 'does not apply discount to the grand total if no coupon' do
        @invoice.update(coupon: nil)
        expect(@invoice.grand_total(@merchant1)).to eq(2000) # $20.00 total for merchant1
        expect(@invoice.grand_total(@merchant2)).to eq(2000) # $20.00 total for merchant2
      end
    end
  end
end