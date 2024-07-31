require 'rails_helper'

RSpec.describe "the admin invoices show page" do
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
    
    @customer = create(:customer)
    @customer2 = create(:customer)

    @invoice1 = create(:invoice, customer: @customer)
    @invoice2 = create(:invoice, customer: @customer)
    @invoice3 = create(:invoice, customer: @customer2)

    @ii1 = InvoiceItem.create!(quantity: 2, unit_price: 500, item_id: @item1.id, invoice_id: @invoice1.id, status: 0)
    @ii2 = InvoiceItem.create!(quantity: 3, unit_price: 1000, item_id: @item2.id, invoice_id: @invoice1.id, status: 1)
    @ii3 = InvoiceItem.create!(quantity: 1, unit_price: 800, item_id: @item3.id, invoice_id: @invoice2.id, status: 2)
  end

  it "lists the attributes of the invoice and the name of its customer" do
    visit admin_invoice_path(@invoice1.id)

    expect(page).to have_content("Invoice Number: #{@invoice1.id}")
    expect(page).to have_select("invoice_status" , selected: @invoice1.status.capitalize)
    expect(page).to have_content("Created On: #{@invoice1.created_at.strftime("%A, %B %d, %Y")}")
    expect(page).to have_content("Customer: #{@customer.first_name} #{@customer.last_name}")
  end

  it "lists the attributes of another invoice and the name of its customer" do
    visit admin_invoice_path(@invoice2.id)

    expect(page).to have_content("Invoice Number: #{@invoice2.id}")
    expect(page).to have_select("invoice_status" , selected: @invoice2.status.capitalize)
    expect(page).to have_content("Created On: #{@invoice2.created_at.strftime("%A, %B %d, %Y")}")
    expect(page).to have_content("Customer: #{@customer.first_name} #{@customer.last_name}")
  end

  it "lists the attributes of another invoice and the name of its customer" do
    visit admin_invoice_path(@invoice3.id)

    expect(page).to have_content("Invoice Number: #{@invoice3.id}")
    expect(page).to have_select("invoice_status" , selected: @invoice3.status.capitalize)
    expect(page).to have_content("Created On: #{@invoice3.created_at.strftime("%A, %B %d, %Y")}")
    expect(page).to have_content("Customer: #{@customer2.first_name} #{@customer2.last_name}")
  end

  it "lists the attributes of each item on the invoice" do
    visit admin_invoice_path(@invoice1.id)

    within("#invoice_items") do
      expect(page).to have_content("Item: #{@item1.name}")
      expect(page).to have_content("Item: #{@item2.name}")
      expect(page).to_not have_content("Item: #{@item3.name}")
    end
    
    within("#invoice_item-#{@ii1.id}") do
      expect(page).to have_content("Item: #{@item1.name}")
      expect(page).to have_content("Quantity Ordered: #{@ii1.quantity}")
      expect(page).to have_content("Item Status: #{@ii1.status}")
      expect(page).to have_content("Price Sold At: $#{@ii1.unit_price / 100}")
    end

    within("#invoice_item-#{@ii2.id}") do
      expect(page).to have_content("Item: #{@item2.name}")
      expect(page).to have_content("Quantity Ordered: #{@ii2.quantity}")
      expect(page).to have_content("Item Status: #{@ii2.status}")
      expect(page).to have_content("Price Sold At: $#{@ii2.unit_price / 100}")
    end
  end

  it "lists the attributes of each item on another invoice" do
    visit admin_invoice_path(@invoice2.id)

    within("#invoice_items") do
      expect(page).to_not have_content("Item: #{@item1.name}")
      expect(page).to_not have_content("Item: #{@item2.name}")
      expect(page).to have_content("Item: #{@item3.name}")
    end

    within("#invoice_item-#{@ii3.id}") do
      expect(page).to have_content("Item: #{@item3.name}")
      expect(page).to have_content("Quantity Ordered: #{@ii3.quantity}")
      expect(page).to have_content("Item Status: #{@ii3.status}")
      expect(page).to have_content("Price Sold At: $#{@ii3.unit_price / 100}")
    end
  end

  it "should show total revenue" do
    visit admin_invoice_path(@invoice1)
  
    within("#total_revenue") do
      expect(page).to have_content("Total Invoice Revenue: $40.00")
    end
  end

  it "allows an admin to update the status" do
    invoice = create(:invoice, status: "in progress")

    visit admin_invoice_path(invoice)

    expect(page).to have_select("invoice_status", selected: "In progress")

    select "Completed", from: "invoice_status"
    click_button "Update Invoice Status"

    expect(current_path).to eq(admin_invoice_path(invoice))
    expect(page).to have_select("invoice_status", selected: "Completed")
    expect(page).to have_text("Invoice has been Updated to completed")
  end
end