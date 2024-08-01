class Item < ApplicationRecord
  has_many :transactions, through: :invoices
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  belongs_to :merchant

  enum status: { disabled: 0, enabled: 1 }
end
