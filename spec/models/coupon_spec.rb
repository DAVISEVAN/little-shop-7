require 'rails_helper'

RSpec.describe Coupon, type: :model do
  # Covers User Story: Coupon Validations and Associations
  describe 'relationships' do
    it { should belong_to(:merchant) }
    it { should have_many(:invoices) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:code) }
    it { should validate_uniqueness_of(:code) }
    it { should validate_presence_of(:amount) }
    it { should validate_presence_of(:discount_type) }
  end

  describe 'enums' do
    it { should define_enum_for(:discount_type).with_values([:percent, :dollar]) }
    it { should define_enum_for(:status).with_values([:active, :inactive]) }
  end
end
