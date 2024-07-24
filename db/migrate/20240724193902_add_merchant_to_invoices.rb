class AddMerchantToInvoices < ActiveRecord::Migration[7.1]
  def change
    add_reference :invoices, :merchant, null: false, foreign_key: true
  end
end
