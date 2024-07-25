require 'rails_helper'

RSpec.describe 'Merchant Dashboard', type: :feature do
  before :each do
    @merchant = create(:merchant)
    @customers = create_list(:customer, 6)

    @customers.each do |customer|
      invoice = create(:invoice, customer: customer)
      item = create(:item, merchant: @merchant)
      create(:invoice_item, invoice: invoice, item: item)
      create_list(:transaction, 3, result: 'success', invoice: invoice)
    end

    visit merchant_dashboard_path(@merchant)
  end
  # User stroy 1, display merchant name 
  it 'displays the name of the merchant' do
    within('h1') do
      expect(page).to have_content(@merchant.name)
    end
  end
  # User story 2, display links to merchant items and invoices index
  it 'displays a link to the merchant items index' do
    within('nav') do
      expect(page).to have_link('Items Index', href: merchant_items_path(@merchant))
    end
  end

  it 'displays a link to the merchant invoices index' do
    within('nav') do
      expect(page).to have_link('Invoices Index', href: merchant_invoices_path(@merchant))
    end
  end
  # User story 3, display top 5 customers with successful transactions
  it 'displays the top 5 customers with the largest number of successful transactions' do
    within('#top-customers') do
      @customers.first(5).each do |customer|
        expect(page).to have_content("#{customer.first_name} #{customer.last_name}")
      end
    end
  end
end
