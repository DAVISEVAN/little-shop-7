require 'rails_helper'

RSpec.describe 'Admin Dashboard', type: :feature do
  before do
    visit admin_dashboard_path
  end
  
  it 'shows a header for the admin dashboard' do
    expect(page).to have_content('Admin Dashboard')
  end

  it 'has a link to the admin merchants index' do
    expect(page).to have_link('Merchants Index', href: admin_merchants_path)
  end

  it 'has a link to the admin invoices index' do
    expect(page).to have_link('Invoices Index', href: admin_invoices_path)
  end
end