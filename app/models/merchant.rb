class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices, through: :items

  enum status: { enabled: 0, disabled: 1 }

  def best_day
    return "" if invoices.blank?
    invoices.max_by{|invoice| invoice.total_revenue}.created_at
  end
end
