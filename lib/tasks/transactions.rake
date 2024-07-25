namespace :csv_load do
    task :transactions => :environment do
      require 'csv'
      CSV.foreach(Rails.root.join('db/data/transactions.csv'), headers: true) do |row|
        Transaction.create!(row.to_hash)
      end
      ActiveRecord::Base.connection.reset_pk_sequence!('transactions')
    end
  end
  