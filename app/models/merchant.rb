class Merchant < ApplicationRecord
  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :invoices, through: :items

  enum status: { enabled: 0, disabled: 1 }

  def top_customers
    Customer.joins(invoices: { invoice_items: :item })
            .joins('INNER JOIN transactions ON transactions.invoice_id = invoices.id')
            .where(items: { merchant_id: id }, transactions: { result: 0 })
            .select('customers.*, count(transactions.id) as transaction_count')
            .group('customers.id')
            .order('transaction_count desc')
            .limit(5)
  end

  def items_ready_to_ship
    items.joins(:invoice_items)
          .where(invoice_items: { status: :pending })
          .select('items.*, invoice_items.invoice_id, invoice_items.created_at AS invoice_created_at')
          .order('invoice_items.created_at ASC')
  end

  def top_5_items_by_revenue
    items
      .select('items.*, SUM(invoice_items.unit_price * invoice_items.quantity) AS total_revenue')
      .joins(invoice_items: { invoice: :transactions })
      .merge(Transaction.successful)
      .group('items.id')
      .order('total_revenue DESC')
      .limit(5)
  end

  def best_day_for_item(item_id)
    subquery = Invoice.joins(:transactions, :invoice_items)
                      .merge(Transaction.success)
                      .where(invoice_items: { item_id: item_id })
                      .select('invoices.id, invoices.created_at, SUM(invoice_items.quantity * invoice_items.unit_price) as revenue')
                      .group('invoices.id')
    
    Invoice.from(subquery, :subquery)
            .order('subquery.revenue DESC, subquery.created_at DESC')
            .limit(1)
            .pluck('subquery.created_at')
            .first
            .strftime("%A, %B %d, %Y")
  end

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
