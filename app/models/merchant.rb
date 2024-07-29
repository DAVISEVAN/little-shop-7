
class Merchant < ApplicationRecord
  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items

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
end
