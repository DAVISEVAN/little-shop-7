require 'rails_helper'

RSpec.describe InvoiceItem, type: :model do
  describe 'associations' do
    it { should belong_to(:item) }
    it { should belong_to(:invoice) }
  end

  describe 'enums' do
    it { should define_enum_for(:status).with_values(packaged: 0, pending: 1, shipped: 2) }
  end
end
