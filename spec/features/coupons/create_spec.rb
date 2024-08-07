require 'rails_helper'

RSpec.describe 'Merchant Coupon Create', type: :feature do
  before :each do
    @merchant = create(:merchant)
    visit merchant_coupons_path(@merchant)
  end

  it 'shows a link to create a new coupon' do
    expect(page).to have_link('Create New Coupon')
    click_link 'Create New Coupon'
    expect(current_path).to eq(new_merchant_coupon_path(@merchant))
  end

  it 'can create a new coupon' do
    visit new_merchant_coupon_path(@merchant)

    fill_in 'Name', with: 'New Coupon'
    fill_in 'Code', with: 'NEW10'
    fill_in 'Amount', with: 10
    select 'Dollar', from: 'Discount type'
    click_button 'Create Coupon'

    expect(current_path).to eq(merchant_coupons_path(@merchant))
    within('#active-coupons') do
      expect(page).to have_content('New Coupon')
      expect(page).to have_content('10.00')
      expect(page).to have_content('Dollar')
    end
  end

  it 'cannot create a coupon with a non-unique code' do
    existing_coupon = create(:coupon, merchant: @merchant, code: 'UNIQUE')

    visit new_merchant_coupon_path(@merchant)

    fill_in 'Name', with: 'Duplicate Coupon'
    fill_in 'Code', with: 'UNIQUE'
    fill_in 'Amount', with: 15
    select 'Percent', from: 'Discount type'
    click_button 'Create Coupon'

    expect(current_path).to eq(merchant_coupons_path(@merchant))
    expect(page).to have_content('Code has already been taken')
  end

  it 'cannot create more than 5 active coupons' do
    create_list(:coupon, 5, merchant: @merchant, status: 0) # 5 active coupons

    visit new_merchant_coupon_path(@merchant)

    fill_in 'Name', with: 'Extra Coupon'
    fill_in 'Code', with: 'EXTRA'
    fill_in 'Amount', with: 5
    select 'Percent', from: 'Discount type'
    click_button 'Create Coupon'

    expect(current_path).to eq(merchant_coupons_path(@merchant))
    expect(page).to have_content('Maximum of 5 active coupons reached')
  end
end
