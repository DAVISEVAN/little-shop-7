class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices, through: :items

  enum status: { enabled: 0, disabled: 1 }
  
  def self.top_5_merchants_by_revenue
      select('merchants.*, SUM(invoice_items.quantity * invoice_items.unit_price) AS total_revenue')
      .joins(invoices: [:transactions, :invoice_items])
      .where('invoices.status = ? AND transactions.result = ?', 1, 0) # assuming 1 = completed, 0 = successful transaction
      .group('merchants.id')
      .order('total_revenue DESC')
      .limit(5)

  end
    def best_day
      return "" if invoices.blank?
      invoices.max_by{|invoice| invoice.total_revenue}.created_at
    end
end
