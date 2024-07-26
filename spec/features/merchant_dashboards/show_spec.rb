require 'rails_helper'

RSpec.describe 'Merchant Dashboard', type: :feature do
  before :each do
    @merchant = Merchant.create!(name: "Test Merchant")

    @item1 = Item.create!(name: "Item 1", description: "Description 1", unit_price: 100, merchant: @merchant)
    @item2 = Item.create!(name: "Item 2", description: "Description 2", unit_price: 200, merchant: @merchant)

    @customer1 = Customer.create!(first_name: "John", last_name: "Doe")
    @customer2 = Customer.create!(first_name: "Jane", last_name: "Smith")
    @customer3 = Customer.create!(first_name: "Alice", last_name: "Johnson")
    @customer4 = Customer.create!(first_name: "Bob", last_name: "Brown")
    @customer5 = Customer.create!(first_name: "Charlie", last_name: "Davis")
    @customer6 = Customer.create!(first_name: "Dana", last_name: "White")

    @invoice1 = Invoice.create!(status: 0, customer: @customer1)
    @invoice2 = Invoice.create!(status: 1, customer: @customer2)
    @invoice3 = Invoice.create!(status: 0, customer: @customer3)
    @invoice4 = Invoice.create!(status: 1, customer: @customer4)
    @invoice5 = Invoice.create!(status: 0, customer: @customer5)
    @invoice6 = Invoice.create!(status: 1, customer: @customer6)

    InvoiceItem.create!(quantity: 5, unit_price: 100, item: @item1, invoice: @invoice1)
    InvoiceItem.create!(quantity: 3, unit_price: 200, item: @item2, invoice: @invoice2)
    InvoiceItem.create!(quantity: 4, unit_price: 150, item: @item1, invoice: @invoice3)
    InvoiceItem.create!(quantity: 2, unit_price: 250, item: @item2, invoice: @invoice4)
    InvoiceItem.create!(quantity: 6, unit_price: 120, item: @item1, invoice: @invoice5)
    InvoiceItem.create!(quantity: 1, unit_price: 300, item: @item2, invoice: @invoice6)

    Transaction.create!(credit_card_number: "1234567812345678", credit_card_expiration_date: "04/25", result: 0, invoice: @invoice1)
    Transaction.create!(credit_card_number: "1234567812345678", credit_card_expiration_date: "04/25", result: 0, invoice: @invoice2)
    Transaction.create!(credit_card_number: "1234567812345678", credit_card_expiration_date: "04/25", result: 0, invoice: @invoice3)
    Transaction.create!(credit_card_number: "1234567812345678", credit_card_expiration_date: "04/25", result: 0, invoice: @invoice4)
    Transaction.create!(credit_card_number: "1234567812345678", credit_card_expiration_date: "04/25", result: 0, invoice: @invoice5)
    Transaction.create!(credit_card_number: "1234567812345678", credit_card_expiration_date: "04/25", result: 0, invoice: @invoice6)
  end

  it 'displays the name of the merchant' do
    visit merchant_dashboard_path(@merchant)

    within('h1') do
      expect(page).to have_content(@merchant.name)
    end
  end

  it 'displays a link to the merchant items index' do
    visit merchant_dashboard_path(@merchant)

    within('nav') do
      expect(page).to have_link('Items Index', href: merchant_items_path(@merchant))
    end
  end

  it 'displays a link to the merchant invoices index' do
    visit merchant_dashboard_path(@merchant)

    within('nav') do
      expect(page).to have_link('Invoices Index', href: merchant_invoices_path(@merchant))
    end
  end

  it 'displays the top 5 customers with the largest number of successful transactions' do
    visit merchant_dashboard_path(@merchant)

    within('#top-customers') do
      @merchant.top_customers.each do |customer|
        expect(page).to have_content("#{customer.first_name} #{customer.last_name}")
      end
    end
  end
    #US 4 Simply Displays all items ready to ship. Name, Created_at, Invoice ID.
  it 'displays all items ready to ship' do
    visit merchant_dashboard_path(@merchant)

    within('#items-ready-to-ship') do
      @merchant.items_ready_to_ship.each do |item|
        expect(page).to have_content(item.name)
        expect(page).to have_content(item.created_at.strftime('%A, %B %d, %Y'))
        expect(page).to have_content(item.invoice_id)
      end
    end
  end

  it 'has a link to invoice show page in Items Ready to Ship' do
    visit merchant_dashboard_path(@merchant)

    expect(current_path).to eq(merchant_dashboard_path(@merchant))

    within('#items-ready-to-ship') do
      click_link(@invoice1.id.to_s) #Put to_s because Capybara doesn't like integers I guess.

      expect(current_path).to eq(merchant_invoice_path(@merchant, @invoice1))
    end
  end

    #US 5 checks for order Oldest to Newest.
    it 'displays the time in the correct format' do
      visit merchant_dashboard_path(@merchant)
  
      within('#items-ready-to-ship') do
        expect(page).to have_content(@item1.created_at.strftime('%A, %B %d, %Y'))
      end
    end

  it 'displays items ready to ship in order from oldest to newest' do
    visit merchant_dashboard_path(@merchant)

    within('#items-ready-to-ship') do
    items = page.all('li')

    expect(items[0]).to have_content(@item1.name)
    expect(items[0]).to have_content(@invoice5.id)
    expect(items[1]).to have_content(@item1.name)
    expect(items[1]).to have_content(@invoice3.id)
    expect(items[2]).to have_content(@item1.name)
    expect(items[2]).to have_content(@invoice1.id)
    end
  end
end

