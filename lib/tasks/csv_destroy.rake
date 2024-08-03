namespace :csv_destroy do
  task :all => :environment do
    [InvoiceItem, Item, Transaction, Invoice, Customer, Merchant].each do |model|
      model.destroy_all
      puts "#{model} data destroyed"
    end
    
    puts 'all data destroyed'
  end
end
