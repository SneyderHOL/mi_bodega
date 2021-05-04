Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations' }
  root 'home#index'
  get 'accounts', to: "accounts#index", as: 'accounts'
  put 'accounts/:id', to: "accounts#update", as: 'update_account'
end
