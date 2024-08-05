require 'rails_helper'

RSpec.describe 'Admin Invoice Show Page', type: :feature do
  before :each do
    @merchant1 = create(:merchant)
    @merchant2 = create(:merchant)
    @customer = create(:customer)
    @coupon = create(:coupon, merchant: @merchant1, discount_type: 'percent', amount: 10)
    @invoice = create(:invoice, customer: @customer, coupon: @coupon, status: 'completed')
    @item1 = create(:item, merchant: @merchant1)
    @item2 = create(:item, merchant: @merchant2)
    @invoice_item1 = create(:invoice_item, invoice: @invoice, item: @item1, quantity: 2, unit_price: 1000) # $20.00 total
    @invoice_item2 = create(:invoice_item, invoice: @invoice, item: @item2, quantity: 1, unit_price: 2000) # $20.00 total

    visit admin_invoice_path(@invoice)
  end


  it 'shows the subtotal and grand total for the invoice' do
    expect(page).to have_content('Subtotal:')
    expect(page).to have_content('$40.00') # $20.00 + $20.00
    expect(page).to have_content('Grand Total:')
    expect(page).to have_content('$38.00') # $40.00 - 10% of $20.00 (only items from merchant1)
  end

  it 'shows the coupon used with a link to the coupon show page' do
    expect(page).to have_content('Coupon Used:')
    expect(page).to have_link(@coupon.name, href: merchant_coupon_path(@coupon.merchant, @coupon))
    expect(page).to have_content(@coupon.code)
  end
end
