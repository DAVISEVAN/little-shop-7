class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices, through: :items

  def top_customers
    Customer
      .joins(invoices: :transactions)
      .where(invoices: { id: self.invoices.pluck(:id) }, transactions: { result: 0 })  # 0 corresponds to 'success'
      .select('customers.*, COUNT(transactions.id) as transaction_count')
      .group('customers.id')
      .order('transaction_count DESC')
      .limit(5)
  end
end