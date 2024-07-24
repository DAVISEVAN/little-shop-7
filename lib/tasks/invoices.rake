namespace :csv_load do
    task :invoices => :environment do
      require 'csv'
      CSV.foreach(Rails.root.join('db/data/invoices.csv'), headers: true) do |row|
        row['status'] = Invoice.statuses[row['status']]
        Invoice.create!(row.to_hash)
      end
      ActiveRecord::Base.connection.reset_pk_sequence!('invoices')
    end
  end
  