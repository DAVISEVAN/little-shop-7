require 'rails_helper'

RSpec.describe Coupon, type: :model do
  # Covers User Story: Coupon Validations and Associations
  describe 'relationships' do
    it { should belong_to(:merchant) }
    it { should have_many(:invoices) }
  end

  describe 'validations' do
    subject { create(:coupon, merchant: create(:merchant)) } # Ensure a valid coupon is created for uniqueness validation

    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:code) }
    it { should validate_uniqueness_of(:code) }
    it { should validate_presence_of(:amount) }
    it { should validate_numericality_of(:amount).is_greater_than(0) }
    it { should validate_presence_of(:discount_type) }
    it { should validate_presence_of(:status) }
  end

  describe 'enums' do
    it { should define_enum_for(:discount_type).with_values([:percent, :dollar]) }
    it { should define_enum_for(:status).with_values([:active, :inactive]) }
  end

  
    describe '#successful_transactions_count' do
      it 'returns the count of successful transactions' do
        coupon = create(:coupon)
        invoice1 = create(:invoice, coupon: coupon)
        invoice2 = create(:invoice, coupon: coupon)
  
        create(:transaction, invoice: invoice1, result: 'success')
        create(:transaction, invoice: invoice1, result: 'failed')
        create(:transaction, invoice: invoice2, result: 'success')
  
        expect(coupon.successful_transactions_count).to eq(2)
      end
  
      it 'returns zero if there are no successful transactions' do
        coupon = create(:coupon)
        invoice = create(:invoice, coupon: coupon)
  
        create(:transaction, invoice: invoice, result: 'failed')
  
        expect(coupon.successful_transactions_count).to eq(0)
      end
    end 
end
