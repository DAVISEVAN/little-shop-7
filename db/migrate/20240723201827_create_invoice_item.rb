class CreateInvoiceItem < ActiveRecord::Migration[7.1]
  def change
    create_table :invoice_items do |t|
      t.integer :quantity
      t.integer :unit_price
      t.references :item, null: false, foreign_key: true
      t.references :invoice, null: false, foreign_key: true
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
