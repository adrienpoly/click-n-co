Rails.application.routes.draw do
  devise_for :users,
    controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  root to: 'pages#home'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :shops, only: [:index, :show]  do
    get 'add/:id', to: 'ordered_products#add', as: 'add'
    get 'remove/:id', to: 'ordered_products#remove', as: 'remove'
    get 'reduce/:id', to: 'ordered_products#reduce', as: 'reduce'
  end
  get '/style', to: 'pages#bootstrap_components'
  get '/test', to: 'pages#test'
  get '/shop2/:id', to: 'shops#show_ajax', as: 'shop2'
  resources :orders, only: [ :index, :create] do

  end



end
