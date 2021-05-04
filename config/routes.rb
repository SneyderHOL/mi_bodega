Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations' }
  root 'home#index'
  get 'accounts', to: 'accounts#index', as: 'accounts'
  put 'accounts/:id', to: 'accounts#update', as: 'update_account'
  #resources :user, only: [:new, :create]
  get 'add_users', to: 'users#new', as: 'add_new_user'
  post 'add_users', to: 'users#create', as: 'create_new_user'
end
