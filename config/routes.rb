Rails.application.routes.draw do
  root to: 'welcome#index'
  namespace :admin do
    get '/', to: 'dashboard#index', as: 'dashboard'
    
    resources :merchants, only: [:index, :show, :new, :create, :edit, :update] do
      member do
        patch :update_status, to: "merchant_status#update"
      end
    end
    resources :invoices, only: [:index, :show, :update]
  end
  
  resources :merchants, only: [:index, :show] do
    get 'dashboard', to: 'merchant_dashboards#show'
    resources :items, controller: 'merchant_items' do
      patch 'toggle_status', to: 'item_statuses#update', on: :member
    end
    resources :invoices, controller: 'merchant_invoices' do
    end
  end

  resources :items do
    member do
      patch 'toggle_status', to: 'item_statuses#update'
    end
  end
end
