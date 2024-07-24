Rails.application.routes.draw do
  namespace :admin do
    get 'invoices/index'
    get 'invoices/show'
    get 'merchants/index'
    get 'merchants/show'
    get 'merchants/edit'
    get '/', to: 'dashboard#index', as: 'dashboard'
    get '/merchants', to: 'merchants#index', as: 'merchants'
    get '/invoices', to: 'invoices#index', as: 'invoices'
    
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
