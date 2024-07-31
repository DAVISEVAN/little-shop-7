class AddStatusToMerchants < ActiveRecord::Migration[7.1]
  def change
    add_column :merchants, :status, :integer, default: 1
  end
end
