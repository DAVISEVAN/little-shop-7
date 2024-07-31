require "rails_helper"

RSpec.describe Invoice, type: :model do
	describe "relationships" do
		it { should belong_to :customer }
    it { should have_many :transactions }
		it { should have_many :invoice_items }
		it { should have_many(:items).through(:invoice_items) }
		it { should have_many(:merchants).through(:items) }
	end
	
	describe "validations" do
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

	describe "instance_methods" do
		it "customer_full_name" do
			expect(@invoice1.customer_full_name).to eq(@customer1.first_name + " " + @customer1.last_name)
			expect(@invoice2.customer_full_name).to eq(@customer1.first_name + " " + @customer1.last_name)
			expect(@invoice3.customer_full_name).to eq(@customer2.first_name + " " + @customer2.last_name)
		end

		it "should calculate the total revenue for the invoice" do
			expect(@invoice1.total_revenue).to eq(1000)
      expect(@invoice2.total_revenue).to eq(1500)
      expect(@invoice3.total_revenue).to eq(500)
		end
	end

	describe "class methods" do
		it "self.incomplete_invoices" do
			expect(Invoice.incomplete_invoices).to eq([@invoice1, @invoice2, @invoice4, @invoice5])
		end
	end
end