# User Story: 12, 13

require 'rails_helper'

RSpec.describe 'Merchant Items Index top 5 items best day', type: :feature do
  before(:each) do
    @merchant = create(:merchant)
    @customer = create(:customer)
    
    @item1 = create(:item, name: "Incredible Leather Computer", merchant: @merchant)
    @item2 = create(:item, name: "Rustic Cotton Knife", merchant: @merchant)
    @item3 = create(:item, name: "Mediocre Concrete Bag", merchant: @merchant)
    @item4 = create(:item, name: "Mediocre Aluminum Table", merchant: @merchant)
    @item5 = create(:item, name: "Small Steel Bottle", merchant: @merchant)

    @invoice1 = create(:invoice, customer: @customer, created_at: "2023-07-18")
    @invoice2 = create(:invoice, customer: @customer, created_at: "2023-07-19")
    @invoice3 = create(:invoice, customer: @customer, created_at: "2023-07-20")
    @invoice4 = create(:invoice, customer: @customer, created_at: "2023-07-21")
    @invoice5 = create(:invoice, customer: @customer, created_at: "2023-07-22")

    create(:invoice_item, item: @item1, invoice: @invoice3, quantity: 10, unit_price: 12000)
    create(:invoice_item, item: @item2, invoice: @invoice4, quantity: 8, unit_price: 10000)
    create(:invoice_item, item: @item3, invoice: @invoice2, quantity: 6, unit_price: 10000)
    create(:invoice_item, item: @item4, invoice: @invoice1, quantity: 5, unit_price: 10000)
    create(:invoice_item, item: @item5, invoice: @invoice5, quantity: 5, unit_price: 10000)

    create(:transaction, invoice: @invoice1, result: 0)
    create(:transaction, invoice: @invoice2, result: 0)
    create(:transaction, invoice: @invoice3, result: 0)
    create(:transaction, invoice: @invoice4, result: 0)
    create(:transaction, invoice: @invoice5, result: 0)

    visit merchant_items_path(@merchant)
  end

  it 'displays the top 5 items by total revenue' do
    within('#top-items') do
      expect(page).to have_content("Incredible Leather Computer - Total Revenue: $1,200.00")
      expect(page).to have_content("Rustic Cotton Knife - Total Revenue: $800.00")
      expect(page).to have_content("Mediocre Concrete Bag - Total Revenue: $600.00")
      expect(page).to have_content("Mediocre Aluminum Table - Total Revenue: $500.00")
      expect(page).to have_content("Small Steel Bottle - Total Revenue: $500.00")
    end
  end

  it 'displays the top selling date for each item' do
    within('#top-items') do
      expect(page).to have_content("Top selling date for Incredible Leather Computer was Thursday, July 20, 2023")
      expect(page).to have_content("Top selling date for Rustic Cotton Knife was Friday, July 21, 2023")
      expect(page).to have_content("Top selling date for Mediocre Concrete Bag was Wednesday, July 19, 2023")
      expect(page).to have_content("Top selling date for Mediocre Aluminum Table was Tuesday, July 18, 2023")
      expect(page).to have_content("Top selling date for Small Steel Bottle was Saturday, July 22, 2023")
    end
  end
end
