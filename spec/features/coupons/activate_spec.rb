require 'rails_helper'

RSpec.describe 'Merchant Coupon Activate', type: :feature do
  before :each do
    @merchant = create(:merchant)
    @coupon = create(:coupon, merchant: @merchant, status: 'inactive')
  end

  it 'activates an inactive coupon' do
    visit merchant_coupon_path(@merchant, @coupon)

    click_button 'Activate'

    expect(current_path).to eq(merchant_coupon_path(@merchant, @coupon))
    expect(page).to have_content('Coupon activated successfully')
    expect(page).to have_content('active')
  end
end
