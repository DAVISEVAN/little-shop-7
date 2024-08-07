class CreateCoupons < ActiveRecord::Migration[7.1]
  def change
    create_table :coupons do |t|
      t.string :name, null: false
      t.string :code, null: false
      t.decimal :amount, precision: 10, scale: 2, null: false
      t.integer :discount_type, null: false, default: 0 # 0 for percent, 1 for dollar
      t.integer :status, null: false, default: 0 # 0 for active, 1 for inactive
      t.references :merchant, null: false, foreign_key: true
      t.timestamps
    end
    add_index :coupons, :code, unique: true
    add_reference :invoices, :coupon, foreign_key: true
  end
end
