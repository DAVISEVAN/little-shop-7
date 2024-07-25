Rails.application.routes.draw do
  namespace :admin do
    get '/', to: 'dashboard#index', as: 'dashboard'
    
    resources :merchants, only: [:index, :show, :edit]
    resources :invoices, only: [:index, :show]
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :merchants do
    resources :items
    resources :invoices
    get '/dashboard', to: 'merchant_dashboards#show', as: 'dashboard'
  end
end
