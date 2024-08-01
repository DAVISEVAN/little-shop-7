require 'rails_helper'

RSpec.describe 'Admin Merchant Update', type: :feature do
  before(:each) do
    @merchant1 = Merchant.create!(name: "Target")
    @merchant2 = Merchant.create!(name: "Walmart")
    @merchant3 = Merchant.create!(name: "Gamestop")
  end

  it 'can navigate to the edit page from the merchant show page' do
    visit admin_merchant_path(@merchant1)

    click_link 'Update Merchant'

    expect(current_path).to eq(edit_admin_merchant_path(@merchant1))
  end

  it 'can update the merchant information' do
    visit edit_admin_merchant_path(@merchant2)

    fill_in 'Name', with: 'Bob'
    click_button 'Submit'
    
    expect(current_path).to eq(admin_merchant_path(@merchant2))

    expect(page).to have_content('Bob')
    expect(page).to have_content('Merchant information has been successfully updated.')
  end
end