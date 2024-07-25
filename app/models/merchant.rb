class Merchant < ApplicationRecord
  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :customers, through: :invoices

  def top_customers
    customers
      .joins(invoices: :transactions)
      .select('customers.*, COUNT(transactions.id) AS transactions_count')
      .where(transactions: { result: Transaction.results[:success] })
      .group('customers.id')
      .order('transactions_count DESC')
      .limit(5)
  end
end
