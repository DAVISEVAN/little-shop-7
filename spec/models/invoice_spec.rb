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
		@customer = create(:customer)
		@customer2 = create(:customer)
		@invoice1 = create(:invoice, customer: @customer)
		@invoice2 = create(:invoice, customer: @customer)
		@invoice3 = create(:invoice, customer: @customer2)
	end

	describe "instance_methods" do
		it "customer_full_name" do
			expect(@invoice1.customer_full_name).to eq(@customer.first_name + " " + @customer.last_name)
			expect(@invoice2.customer_full_name).to eq(@customer.first_name + " " + @customer.last_name)
			expect(@invoice3.customer_full_name).to eq(@customer2.first_name + " " + @customer2.last_name)
		end
	end
end
