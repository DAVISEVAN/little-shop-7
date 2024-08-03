require 'rails_helper'

RSpec.describe 'Merchant Coupons Index', type: :feature do
  before :each do
    @merchant = create(:merchant)
    @coupon1 = create(:coupon, merchant: @merchant, status: 'active')
    @coupon2 = create(:coupon, merchant: @merchant, status: 'inactive')

    visit merchant_dashboard_path(@merchant)
  end

  it 'shows a link to view all coupons' do
    expect(page).to have_link('View All Coupons')
    click_link 'View All Coupons'
    expect(current_path).to eq(merchant_coupons_path(@merchant))
  end

  it 'displays all coupons with details' do
    visit merchant_coupons_path(@merchant)

    within('#active-coupons') do
      expect(page).to have_content(@coupon1.name)
      expect(page).to have_link(@coupon1.name)
      expect(page).to have_content(@coupon1.amount)
      expect(page).to have_content(@coupon1.discount_type == 'percent' ? 'Percent' : 'Dollar')
    end

    within('#inactive-coupons') do
      expect(page).to have_content(@coupon2.name)
      expect(page).to have_link(@coupon2.name)
      expect(page).to have_content(@coupon2.amount)
      expect(page).to have_content(@coupon2.discount_type == 'percent' ? 'Percent' : 'Dollar')
    end
  end
end
