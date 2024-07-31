require 'rails_helper'

RSpec.describe "merchant index", type: :view do
  before(:each) do
    @merchant1 = Merchant.create!(name: "Target", status: 0)
    @merchant2 = Merchant.create!(name: "Walmart", status: 0)
    @merchant3 = Merchant.create!(name: "Gamestop", status: 1)
    @merchant4 = Merchant.create!(name: "Sears", status: 0)
    @merchant5 = Merchant.create!(name: "Home Depot", status: 1)
    @merchant6 = Merchant.create!(name: "Starbucks", status: 0)

    @item1 = Item.create!(name: "Milk", description: "2%", unit_price: 400, merchant_id: @merchant1.id)
    @item2 = Item.create!(name: "Beer", description: "IPA", unit_price: 1000, merchant_id: @merchant1.id)
    @item3 = Item.create!(name: "Crackers", description: "Salty Bois", unit_price: 800, merchant_id: @merchant2.id)
    @item4 = Item.create!(name: "Oil", description: "For ya car", unit_price: 15000, merchant_id: @merchant2.id)
    @item5 = Item.create!(name: "Halo", description: "Timeless classic", unit_price: 40000, merchant_id: @merchant3.id)
    @item6 = Item.create!(name: "COD", description: "Its a game!", unit_price: 1500, merchant_id: @merchant4.id)
    @item7 = Item.create!(name: "Coffee", description: "Yum", unit_price: 4000, merchant_id: @merchant4.id)
    @item8 = Item.create!(name: "Shovel", description: "Dig em", unit_price: 2500, merchant_id: @merchant5.id)
    @item9 = Item.create!(name: "Bucket", description: "Fill er up", unit_price: 5400, merchant_id: @merchant5.id)
    @item10 = Item.create!(name: "Tumbler", description: "Drink out of this guy", unit_price: 10000, merchant_id: @merchant6.id)
    @item11 = Item.create!(name: "Straw", description: "Succ", unit_price: 3500, merchant_id: @merchant6.id)

    @customer1 = Customer.create!(first_name: "Bob", last_name: "The Builder")
    @customer2 = Customer.create!(first_name: "Ted", last_name: "Bear")
    @customer3 = Customer.create!(first_name: "Shaggy", last_name: "Mystery")
    @customer4 = Customer.create!(first_name: "Velma", last_name: "Nerd")
    @customer5 = Customer.create!(first_name: "Scooby", last_name: "Doo")
    @customer6 = Customer.create!(first_name: "Vinny", last_name: "Cheddah")
    @customer7 = Customer.create!(first_name: "Dexter", last_name: "Lab")

    @invoice1 = Invoice.create!(status: 1, customer_id: @customer1.id) # 4
    @invoice2 = Invoice.create!(status: 1, customer_id: @customer1.id) # 2
    @invoice3 = Invoice.create!(status: 1, customer_id: @customer1.id)
    @invoice4 = Invoice.create!(status: 1, customer_id: @customer1.id) # 3
    @invoice5 = Invoice.create!(status: 1, customer_id: @customer1.id) # 1
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

    InvoiceItem.create!(quantity: 2, unit_price: 5000, item_id: @item1.id, invoice_id: @invoice1.id, status: 0)
    InvoiceItem.create!(quantity: 3, unit_price: 505, item_id: @item2.id, invoice_id: @invoice2.id, status: 1)
    InvoiceItem.create!(quantity: 1, unit_price: 400, item_id: @item3.id, invoice_id: @invoice3.id, status: 2)
    InvoiceItem.create!(quantity: 4, unit_price: 100, item_id: @item4.id, invoice_id: @invoice4.id, status: 0)
    InvoiceItem.create!(quantity: 3, unit_price: 1000, item_id: @item5.id, invoice_id: @invoice5.id, status: 1)
    InvoiceItem.create!(quantity: 2, unit_price: 45000, item_id: @item6.id, invoice_id: @invoice6.id, status: 2)
    InvoiceItem.create!(quantity: 2, unit_price: 4300, item_id: @item6.id, invoice_id: @invoice7.id, status: 2)
    InvoiceItem.create!(quantity: 5, unit_price: 1500, item_id: @item7.id, invoice_id: @invoice8.id, status: 2)
    InvoiceItem.create!(quantity: 7, unit_price: 7000, item_id: @item7.id, invoice_id: @invoice9.id, status: 2)
    InvoiceItem.create!(quantity: 3, unit_price: 200, item_id: @item8.id, invoice_id: @invoice10.id, status: 2)
    InvoiceItem.create!(quantity: 1, unit_price: 6200, item_id: @item8.id, invoice_id: @invoice10.id, status: 2)
    InvoiceItem.create!(quantity: 8, unit_price: 1300, item_id: @item9.id, invoice_id: @invoice11.id, status: 2)

    @transaction1 = Transaction.create!(credit_card_number: "4654405418249632", credit_card_expiration_date: "04/27", result: 0, invoice_id: @invoice1.id) # customer1
    @transaction2 = Transaction.create!(credit_card_number: "4654405418249633", credit_card_expiration_date: "04/26", result: 0, invoice_id: @invoice2.id) # customer1
    @transaction3 = Transaction.create!(credit_card_number: "4654405418249634", credit_card_expiration_date: "04/25", result: 0, invoice_id: @invoice3.id) # customer1
    @transaction4 = Transaction.create!(credit_card_number: "4654405418249635", credit_card_expiration_date: "04/24", result: 0, invoice_id: @invoice4.id) # customer1
    @transaction5 = Transaction.create!(credit_card_number: "4654405418249636", credit_card_expiration_date: "04/23", result: 0, invoice_id: @invoice5.id) # customer1
    @transaction6 = Transaction.create!(credit_card_number: "4654405418249637", credit_card_expiration_date: "04/22", result: 0, invoice_id: @invoice6.id) # customer2
    @transaction7 = Transaction.create!(credit_card_number: "4654405418249638", credit_card_expiration_date: "04/21", result: 0, invoice_id: @invoice7.id) # customer2
    @transaction8 = Transaction.create!(credit_card_number: "4654405418249639", credit_card_expiration_date: "04/20", result: 0, invoice_id: @invoice8.id) # customer2
    @transaction9 = Transaction.create!(credit_card_number: "4654405418249631", credit_card_expiration_date: "04/19", result: 0, invoice_id: @invoice9.id) # customer2
    @transaction10 = Transaction.create!(credit_card_number: "4654405418249642", credit_card_expiration_date: "04/28", result: 0, invoice_id: @invoice10.id) # customer3
    @transaction11 = Transaction.create!(credit_card_number: "4654405418249642", credit_card_expiration_date: "04/28", result: 0, invoice_id: @invoice11.id) # customer3
    @transaction12 = Transaction.create!(credit_card_number: "4654405418249642", credit_card_expiration_date: "04/28", result: 0, invoice_id: @invoice12.id) # customer3
    @transaction13 = Transaction.create!(credit_card_number: "4654405418249642", credit_card_expiration_date: "04/28", result: 0, invoice_id: @invoice13.id) # customer4
    @transaction14 = Transaction.create!(credit_card_number: "4654405418249642", credit_card_expiration_date: "04/28", result: 0, invoice_id: @invoice14.id) # customer4
    @transaction15 = Transaction.create!(credit_card_number: "4654405418249642", credit_card_expiration_date: "04/28", result: 0, invoice_id: @invoice15.id) # customer5
  end

  it 'shows the name of each merchant in the system in disabled or enabled sections' do
    visit admin_merchants_path

    within("#enabled_merchants") do
      expect(page).to have_content(@merchant1.name)
      expect(page).to have_content(@merchant2.name)
      expect(page).to_not have_content(@merchant3.name)
    end

    within("#disabled_merchants") do
      expect(page).to_not have_content(@merchant1.name)
      expect(page).to_not have_content(@merchant2.name)
      expect(page).to have_content(@merchant3.name)
    end
  end

  it "has a functional button to update each merchant's status to 'enabled' or 'disabled'" do
    visit admin_merchants_path

    within("#merchant-#{@merchant1.id}") do
      click_button "Disable"
    end

    expect(current_path).to eq admin_merchants_path

    within("#merchant-#{@merchant1.id}") do
      expect(page).to have_button("Enable")
    end

    within("#merchant-#{@merchant3.id}") do
      click_button "Enable"
    end

    expect(current_path).to eq admin_merchants_path

    within("#merchant-#{@merchant3.id}") do
      expect(page).to have_button("Disable")
    end
  end

  it "has a section that displays the top 5 merchants by revenue" do
    visit admin_merchants_path

    within("#top_5_merchants_by_revenue") do
      expect(@merchant4.name).to appear_before(@merchant5.name)
      expect(@merchant5.name).to appear_before(@merchant1.name)
      expect(@merchant1.name).to appear_before(@merchant3.name)
      expect(@merchant3.name).to appear_before(@merchant2.name)
      expect(page).to_not have_content(@merchant6.name)
    end
  end
end
