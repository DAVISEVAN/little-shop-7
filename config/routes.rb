Rails.application.routes.draw do
  resources :merchants, only: [:index, :show] do
    resource :dashboard, only: [:show], controller: 'merchant_dashboards'
    resources :items, only: [:index], controller: 'merchant_items'
    resources :invoices, only: [:index], controller: 'merchant_invoices'
  end
end
