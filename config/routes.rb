Rails.application.routes.draw do
  namespace :admin do
    get '/', to: 'dashboard#index', as: 'dashboard'
    
    resources :merchants, only: [:index, :show, :edit]
    resources :invoices, only: [:index, :show]
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :merchants, only: [:index, :show] do
    resource :dashboard, only: [:show], controller: 'merchant_dashboards'
    resources :items, only: [:index], controller: 'merchant_items'
    resources :invoices, only: [:index], controller: 'merchant_invoices'
  end
end
