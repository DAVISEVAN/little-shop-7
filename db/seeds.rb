# Create merchant
merchant = Merchant.create!(name: "Test Merchant")

# Create customer
customer = Customer.create!(first_name: "John", last_name: "Doe")

# Create some coupons
coupon1 = Coupon.create!(name: "10% Off", code: "TENOFF", amount: 10, discount_type: "percent", status: "active", merchant: merchant)
coupon2 = Coupon.create!(name: "$5 Off", code: "FIVEOFF", amount: 500, discount_type: "dollar", status: "active", merchant: merchant)

# Create items
item1 = Item.create!(name: "Item 1", description: "Description 1", unit_price: 1000, merchant: merchant)
item2 = Item.create!(name: "Item 2", description: "Description 2", unit_price: 2000, merchant: merchant)

# Create an invoice with a coupon
invoice = Invoice.create!(customer: customer, coupon: coupon1, status: "completed")

# Create invoice items
InvoiceItem.create!(invoice: invoice, item: item1, quantity: 2, unit_price: 1000) # $20.00 total
InvoiceItem.create!(invoice: invoice, item: item2, quantity: 1, unit_price: 2000) # $20.00 total

puts "Merchant ID: #{merchant.id}"

puts "Invoice ID: #{invoice.id}"

puts "Seed data created successfully!"

puts "for invoices coupons show"