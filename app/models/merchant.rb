class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices, through: :items
  has_many :customers, through: :invoices
  def top_customers
    Customer
      .joins(invoices: :transactions)
      .where(transactions: { result: 0 })  # 0 corresponds to 'success'
      .select("customers.*, COUNT(transactions.id) AS transaction_count")
      .group("customers.id")
      .order("transaction_count DESC")
      .limit(5)
  end
end
