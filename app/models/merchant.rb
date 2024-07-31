class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices, through: :items

  enum status: { enabled: 0, disabled: 1 }
end
