require 'rails_helper'

RSpec.describe 'Merchant Coupon Show Page', type: :feature do
  before :each do
    @merchant = create(:merchant)
    @coupon = create(:coupon, merchant: @merchant, name: 'Test Coupon', code: 'TEST10', amount: 10, discount_type: 'dollar', status: 'active')
    @customer = create(:customer)
    @invoice1 = create(:invoice, customer: @customer, coupon: @coupon)
    @invoice2 = create(:invoice, customer: @customer, coupon: @coupon)
    @transaction1 = create(:transaction, invoice: @invoice1, result: 'success')
    @transaction2 = create(:transaction, invoice: @invoice2, result: 'failed')

    visit merchant_coupon_path(@merchant, @coupon)
  end

  it 'displays the coupon details' do
    expect(page).to have_content(@coupon.name)
    expect(page).to have_content(@coupon.code)
    expect(page).to have_content(@coupon.amount)
    expect(page).to have_content(@coupon.discount_type)
    expect(page).to have_content(@coupon.status)
    expect(page).to have_content('Times Used: 1') # Only successful transactions count
  end
end
