require "rails_helper"

RSpec.describe Customer, type: :model do
  describe "relationships" do
    it { should have_many :invoices}
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
    @customer3 = Customer.create!(first_name: "Shaggy", last_name: "Mystery")
    @customer4 = Customer.create!(first_name: "Velma", last_name: "Nerd")
    @customer5 = Customer.create!(first_name: "Scooby", last_name: "Doo")
    @customer6 = Customer.create!(first_name: "Vinny", last_name: "Cheddah")
    @customer7 = Customer.create!(first_name: "Dexter", last_name: "Lab")

    @invoice1 = Invoice.create!(status: 1, customer_id: @customer1.id)
    @invoice2 = Invoice.create!(status: 1, customer_id: @customer1.id)
    @invoice3 = Invoice.create!(status: 1, customer_id: @customer1.id)
    @invoice4 = Invoice.create!(status: 1, customer_id: @customer1.id)
    @invoice5 = Invoice.create!(status: 1, customer_id: @customer1.id)
    @invoice6 = Invoice.create!(status: 1, customer_id: @customer2.id)
    @invoice7 = Invoice.create!(status: 1, customer_id: @customer2.id)
    @invoice8 = Invoice.create!(status: 1, customer_id: @customer2.id)
    @invoice9 = Invoice.create!(status: 1, customer_id: @customer2.id)
    @invoice10 = Invoice.create!(status: 1, customer_id: @customer3.id)
    @invoice11 = Invoice.create!(status: 1, customer_id: @customer3.id)
    @invoice12 = Invoice.create!(status: 1, customer_id: @customer3.id)
    @invoice13 = Invoice.create!(status: 1, customer_id: @customer4.id)
    @invoice14 = Invoice.create!(status: 1, customer_id: @customer4.id)
    @invoice15 = Invoice.create!(status: 1, customer_id: @customer5.id)


    InvoiceItem.create!(quantity: 2, unit_price: 500, item_id: @item1.id, invoice_id: @invoice1.id)
    InvoiceItem.create!(quantity: 3, unit_price: 500, item_id: @item2.id, invoice_id: @invoice2.id)
    InvoiceItem.create!(quantity: 1, unit_price: 500, item_id: @item3.id, invoice_id: @invoice3.id)
    InvoiceItem.create!(quantity: 4, unit_price: 500, item_id: @item4.id, invoice_id: @invoice4.id)
    InvoiceItem.create!(quantity: 3, unit_price: 500, item_id: @item5.id, invoice_id: @invoice5.id)
    InvoiceItem.create!(quantity: 2, unit_price: 500, item_id: @item6.id, invoice_id: @invoice6.id)

    @transaction1 = Transaction.create!(credit_card_number: "4654405418249632", credit_card_expiration_date: "04/27", result: 0, invoice_id: @invoice1.id) # customer1
    @transaction2 = Transaction.create!(credit_card_number: "4654405418249633", credit_card_expiration_date: "04/26", result: 0, invoice_id: @invoice2.id) # customer1
    @transaction3 = Transaction.create!(credit_card_number: "4654405418249634", credit_card_expiration_date: "04/25", result: 0, invoice_id: @invoice3.id) # customer1
    @transaction4 = Transaction.create!(credit_card_number: "4654405418249635", credit_card_expiration_date: "04/24", result: 0, invoice_id: @invoice4.id) # customer1
    @transaction5 = Transaction.create!(credit_card_number: "4654405418249636", credit_card_expiration_date: "04/23", result: 0, invoice_id: @invoice5.id) # customer1
    @transaction6 = Transaction.create!(credit_card_number: "4654405418249637", credit_card_expiration_date: "04/22", result: 0, invoice_id: @invoice6.id) # customer2
    @transaction6 = Transaction.create!(credit_card_number: "4654405418249638", credit_card_expiration_date: "04/21", result: 0, invoice_id: @invoice7.id) # customer2
    @transaction6 = Transaction.create!(credit_card_number: "4654405418249639", credit_card_expiration_date: "04/20", result: 0, invoice_id: @invoice8.id) # customer2
    @transaction6 = Transaction.create!(credit_card_number: "4654405418249631", credit_card_expiration_date: "04/19", result: 0, invoice_id: @invoice9.id) # customer2
    @transaction6 = Transaction.create!(credit_card_number: "4654405418249642", credit_card_expiration_date: "04/28", result: 0, invoice_id: @invoice10.id) # customer3
    @transaction6 = Transaction.create!(credit_card_number: "4654405418249642", credit_card_expiration_date: "04/28", result: 0, invoice_id: @invoice11.id) # customer3
    @transaction6 = Transaction.create!(credit_card_number: "4654405418249642", credit_card_expiration_date: "04/28", result: 0, invoice_id: @invoice12.id) # customer3
    @transaction6 = Transaction.create!(credit_card_number: "4654405418249642", credit_card_expiration_date: "04/28", result: 0, invoice_id: @invoice13.id) # customer4
    @transaction6 = Transaction.create!(credit_card_number: "4654405418249642", credit_card_expiration_date: "04/28", result: 0, invoice_id: @invoice14.id) # customer4
    @transaction6 = Transaction.create!(credit_card_number: "4654405418249642", credit_card_expiration_date: "04/28", result: 0, invoice_id: @invoice15.id) # customer5
  end

  describe "class methods" do
    it "self.top_5_customers" do
      expect(Customer.top_5_customers).to eq([@customer1, @customer2, @customer3, @customer4, @customer5])
    end
  end

  describe "instance methods" do
    it "full_name" do
      expect(@customer1.full_name).to eq("Bob The Builder")
      expect(@customer2.full_name).to eq("Ted Bear")
      expect(@customer3.full_name).to eq("Shaggy Mystery")
      expect(@customer4.full_name).to eq("Velma Nerd")
      expect(@customer5.full_name).to eq("Scooby Doo")
      expect(@customer6.full_name).to eq("Vinny Cheddah")
      expect(@customer7.full_name).to eq("Dexter Lab")
    end
  end
end