Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations' }
  root 'home#index'
  get 'accounts', to: 'accounts#index', as: 'accounts'
  put 'accounts/:id', to: 'accounts#update', as: 'update_account'
  get 'add_users', to: 'users#new', as: 'add_new_user'
  post 'add_users', to: 'users#create', as: 'create_new_user'
  get 'billing_portal', to: 'billing_portal#new', as: 'billing_portal'
  resources :boxes, except: [:edit, :update, :destroy] do
    member do
      get 'qr_code', to: 'boxes#show_code'
    end
    resources :items, except: [:index, :destroy] do
      member do
        post 'use_item'
      end
    end
  end
end
