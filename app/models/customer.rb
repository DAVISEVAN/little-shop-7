class Customer < ApplicationRecord
	has_many :invoices
	has_many :transactions, through: :invoices

	def self.top_5_customers
		joins(:transactions)
		.where("transactions.result = 0")
		.select("customers.*, count(transactions.id) as transaction_count")
		.group("customers.id")
		.order(transaction_count: :desc)
		.limit(5)
	end

	def full_name
		first_name + " " + last_name
	end
end
