require 'rails_helper'

RSpec.describe "the admin invoices show page" do
  before(:each) do
      @customer = create(:customer)
      @customer2 = create(:customer)
      @invoice1 = create(:invoice, customer: @customer)
      @invoice2 = create(:invoice, customer: @customer)
      @invoice3 = create(:invoice, customer: @customer2)
  end

  it "lists the attributes of the invoice and the name of its customer" do
    visit admin_invoice_path(@invoice1.id)

    expect(page).to have_content("Invoice Number: #{@invoice1.id}")
    expect(page).to have_content("Invoice Status: #{@invoice1.status}")
    expect(page).to have_content("Created On: #{@invoice1.created_at.strftime("%A, %B %d, %Y")}")
    expect(page).to have_content("Customer: #{@customer.first_name} #{@customer.last_name}")
  end

  it "lists the attributes of another invoice and the name of its customer" do
    visit admin_invoice_path(@invoice2.id)

    expect(page).to have_content("Invoice Number: #{@invoice2.id}")
    expect(page).to have_content("Invoice Status: #{@invoice2.status}")
    expect(page).to have_content("Created On: #{@invoice2.created_at.strftime("%A, %B %d, %Y")}")
    expect(page).to have_content("Customer: #{@customer.first_name} #{@customer.last_name}")
  end

  it "lists the attributes of another invoice and the name of its customer" do
    visit admin_invoice_path(@invoice3.id)

    expect(page).to have_content("Invoice Number: #{@invoice3.id}")
    expect(page).to have_content("Invoice Status: #{@invoice3.status}")
    expect(page).to have_content("Created On: #{@invoice3.created_at.strftime("%A, %B %d, %Y")}")
    expect(page).to have_content("Customer: #{@customer2.first_name} #{@customer2.last_name}")
  end
end