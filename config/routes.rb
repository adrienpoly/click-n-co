Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  mount Attachinary::Engine => "/attachinary"
  devise_for :users,
    controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  root to: 'pages#home'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :products, only: [:index]

  resources :shops, only: [:index, :show]  do
    get 'add/:id',    to: 'ordered_products#add',     as: 'add'
    get 'remove/:id', to: 'ordered_products#remove',  as: 'remove'
    get 'reduce/:id', to: 'ordered_products#reduce',  as: 'reduce'
  end


  namespace :retailer do
    resources :shops, only: [:index, :show] do
      resources :orders, only: [:show, :update]
    end

  end
  resources :orders, only: [:index, :show, :create, :update]
  resources :orders, only: [:show, :create] do
    resources :payments, only: [:new, :create]
  end

  get '/style', to: 'pages#bootstrap_components'
  get '/clear-session', to: 'orders#clear_session_cart'
end

