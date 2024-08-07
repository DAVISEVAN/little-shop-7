require 'rails_helper'

RSpec.describe 'Merchant Coupon Deactivate', type: :feature do
  before :each do
    @merchant = create(:merchant)
    @coupon = create(:coupon, merchant: @merchant, status: 'active')
    @customer = create(:customer)
    @invoice = create(:invoice, customer: @customer, coupon: @coupon, status: 'in progress') # Use the correct status
  end

  it 'deactivates a coupon with no in-progress invoices' do
    visit merchant_coupon_path(@merchant, @coupon)
    @invoice.update(status: 'completed')

    click_button 'Deactivate'

    expect(current_path).to eq(merchant_coupon_path(@merchant, @coupon))
    expect(page).to have_content('Coupon deactivated successfully')
    expect(page).to have_content('inactive')
  end

  it 'does not deactivate a coupon with in-progress invoices' do
    visit merchant_coupon_path(@merchant, @coupon)

    click_button 'Deactivate'

    expect(current_path).to eq(merchant_coupon_path(@merchant, @coupon))
    expect(page).to have_content('Cannot deactivate coupon with in-progress invoices')
    expect(page).to have_content('active')
  end
end
