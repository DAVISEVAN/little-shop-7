# Clear existing data
Merchant.destroy_all
Customer.destroy_all
Item.destroy_all
Invoice.destroy_all
InvoiceItem.destroy_all
Coupon.destroy_all

# Create merchants
merchant1 = Merchant.create!(name: 'Merchant One')
merchant2 = Merchant.create!(name: 'Merchant Two')

# Create customers
customer1 = Customer.create!(first_name: 'John', last_name: 'Doe')
customer2 = Customer.create!(first_name: 'Jane', last_name: 'Smith')

# Create items
item1 = Item.create!(name: 'Item One', description: 'Description One', unit_price: 1000, merchant: merchant1)
item2 = Item.create!(name: 'Item Two', description: 'Description Two', unit_price: 2000, merchant: merchant1)
item3 = Item.create!(name: 'Item Three', description: 'Description Three', unit_price: 3000, merchant: merchant2)

# Create coupons
coupon1 = Coupon.create!(name: 'Coupon1', code: 'CODE1', amount: 10, discount_type: 'percent', status: 'active', merchant: merchant1)
coupon2 = Coupon.create!(name: 'Coupon2', code: 'CODE2', amount: 15, discount_type: 'percent', status: 'active', merchant: merchant1)
coupon3 = Coupon.create!(name: 'Coupon3', code: 'CODE3', amount: 5, discount_type: 'dollar', status: 'active', merchant: merchant1)
coupon4 = Coupon.create!(name: 'Coupon4', code: 'CODE4', amount: 20, discount_type: 'percent', status: 'inactive', merchant: merchant1)
coupon5 = Coupon.create!(name: 'Coupon5', code: 'CODE5', amount: 10, discount_type: 'dollar', status: 'inactive', merchant: merchant1)
coupon6 = Coupon.create!(name: 'Coupon6', code: 'CODE6', amount: 25, discount_type: 'percent', status: 'active', merchant: merchant2)

# Create invoices
invoice1 = Invoice.create!(status: 'completed', customer: customer1, coupon: coupon1)
invoice2 = Invoice.create!(status: 'completed', customer: customer2, coupon: coupon2)
invoice3 = Invoice.create!(status: 'completed', customer: customer1, coupon: coupon3)
invoice4 = Invoice.create!(status: 'completed', customer: customer2, coupon: coupon4)
invoice5 = Invoice.create!(status: 'completed', customer: customer1, coupon: coupon5)
invoice6 = Invoice.create!(status: 'completed', customer: customer2, coupon: coupon6)

# Create invoice items
InvoiceItem.create!(invoice: invoice1, item: item1, quantity: 2, unit_price: item1.unit_price, status: 'shipped')
InvoiceItem.create!(invoice: invoice1, item: item2, quantity: 1, unit_price: item2.unit_price, status: 'shipped')
InvoiceItem.create!(invoice: invoice2, item: item3, quantity: 3, unit_price: item3.unit_price, status: 'shipped')
InvoiceItem.create!(invoice: invoice3, item: item1, quantity: 1, unit_price: item1.unit_price, status: 'shipped')
InvoiceItem.create!(invoice: invoice4, item: item2, quantity: 2, unit_price: item2.unit_price, status: 'shipped')
InvoiceItem.create!(invoice: invoice5, item: item3, quantity: 1, unit_price: item3.unit_price, status: 'shipped')
InvoiceItem.create!(invoice: invoice6, item: item1, quantity: 1, unit_price: item1.unit_price, status: 'shipped')
InvoiceItem.create!(invoice: invoice6, item: item3, quantity: 1, unit_price: item3.unit_price, status: 'shipped')
