class Invoice < ApplicationRecord
  belongs_to :customer
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items

  enum status: { "in progress": 0, completed: 1, cancelled: 2 }

  def customer_full_name
    customer.first_name + " " + customer.last_name
  end

  def self.incomplete_invoices
    joins(:invoice_items)
    .where("invoice_items.status != 2")
    .select("invoices.*")
    .group("invoices.id")
    .order("invoices.created_at")
  end
end
