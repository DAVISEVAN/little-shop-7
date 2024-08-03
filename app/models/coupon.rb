class Coupon < ApplicationRecord
  # Associations
  belongs_to :merchant
  has_many :invoices

  # Validations
  validates :name, presence: true
  validates :code, presence: true, uniqueness: true
  validates :amount, presence: true, numericality: { greater_than: 0 }
  validates :discount_type, presence: true
  validates :status, presence: true

  # Enums for discount type and status
  enum discount_type: { percent: 0, dollar: 1 }
  enum status: { active: 0, inactive: 1 }

  # Custom validation to ensure a merchant can have at most 5 active coupons
  validate :maximum_active_coupons_per_merchant, if: :merchant

  private

  def maximum_active_coupons_per_merchant
    if merchant.coupons.active.count >= 5
      errors.add(:base, 'Maximum of 5 active coupons reached')
    end
  end
end
