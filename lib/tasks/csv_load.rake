namespace :csv_load do
  task :all => :environment do
    Rake::Task['csv_load:customers'].invoke
    Rake::Task['csv_load:invoices'].invoke
    Rake::Task['csv_load:transactions'].invoke
    Rake::Task['csv_load:merchants'].invoke
    Rake::Task['csv_load:items'].invoke
    Rake::Task['csv_load:invoice_items'].invoke
    
    puts 'all data loaded'
  end
end
