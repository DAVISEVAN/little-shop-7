class InvoiceItem < ApplicationRecord
  belongs_to :item 
  belongs_to :invoice

  enum status: { pending: 0, packaged: 1, shipped: 2 }

  def total_revenue
    quantity * unit_price
  end
  
  def converted_price
    unit_price/100

  end
end
