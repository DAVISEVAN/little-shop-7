namespace :csv_load do
    task :invoice_items => :environment do
      require 'csv'
      CSV.foreach(Rails.root.join('db/data/invoice_items.csv'), headers: true) do |row|
        row['unit_price'] = row['unit_price'].to_i
        InvoiceItem.create!(row.to_hash)
      end
      ActiveRecord::Base.connection.reset_pk_sequence!('invoice_items')
    end
  end
  