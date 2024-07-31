
require 'rails_helper'

RSpec.describe "the admin invoices index page" do
  before(:each) do
      @customer = create(:customer)
      @customer2 = create(:customer)
      @invoice1 = create(:invoice, customer: @customer)
      @invoice2 = create(:invoice, customer: @customer)
      @invoice3 = create(:invoice, customer: @customer2)
  end

  it "has a list of all invoice ID's in the system that link to each invoice show page" do
    visit admin_invoices_path
    
    within("#invoice_ids") do
      expect(page).to have_content("Invoice ID: #{@invoice1.id}")
      expect(page).to have_content("Invoice ID: #{@invoice2.id}")
      expect(page).to have_content("Invoice ID: #{@invoice3.id}")
    end
    
    within("#invoice-#{@invoice1.id}") do
      click_link @invoice1.id
    end

    expect(current_path).to eq(admin_invoice_path(@invoice1.id))

    visit admin_invoices_path

    within("#invoice-#{@invoice2.id}") do
      click_link @invoice2.id
    end

    expect(current_path).to eq(admin_invoice_path(@invoice2.id))

    visit admin_invoices_path

    within("#invoice-#{@invoice3.id}") do
      click_link @invoice3.id
    end

    expect(current_path).to eq(admin_invoice_path(@invoice3.id))
  end
end

