Rails.application.routes.draw do
  root to: 'transactions#new'
  resources :transactions, only: [:new, :create, :index]
end
