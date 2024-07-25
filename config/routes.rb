Rails.application.routes.draw do
  resources :merchants, only: [] do
    get 'dashboard', to: 'merchant_dashboards#show'
    resources :items, only: [:index, :show]
    resources :invoices, only: [:index, :show]
  end
end
