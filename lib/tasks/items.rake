namespace :csv_load do
    task :items => :environment do
      require 'csv'
      CSV.foreach(Rails.root.join('db/data/items.csv'), headers: true) do |row|
        row['unit_price'] = row['unit_price'].to_i
        row['status'] = 0 # Set default value for status
        Item.create!(row.to_hash)
      end
      ActiveRecord::Base.connection.reset_pk_sequence!('items')
    end
  end
  