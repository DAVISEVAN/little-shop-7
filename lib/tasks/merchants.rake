namespace :csv_load do
    task :merchants => :environment do
      require 'csv'
      CSV.foreach(Rails.root.join('db/data/merchants.csv'), headers: true) do |row|
        Merchant.create!(row.to_hash)
      end
      ActiveRecord::Base.connection.reset_pk_sequence!('merchants')
    end
  end
  