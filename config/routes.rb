Rails.application.routes.draw do
  namespace :admin do
    get '/', to: 'dashboard#index', as: 'dashboard'
    
    resources :merchants, only: [:index, :show, :edit]
    resources :invoices, only: [:index, :show]
  end
  
  resources :merchants do
    get 'dashboard', to: 'merchant_dashboards#show'
    resources :items, controller: 'merchant_items' do
      patch 'toggle_status', to: 'item_statuses#update', on: :member
    end
    resources :invoices, controller: 'merchant_invoices'
  end
  resources :items do
    member do
      patch 'toggle_status', to: 'item_statuses#update'
    end
  end
end
