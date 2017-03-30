Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  mount Attachinary::Engine => "/attachinary"
  devise_for :users,
    controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  root to: 'pages#home'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :products, only: [:index] do
    get :search, :on => :collection
  end

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

  resources :orders, only: [:index, :create, :update, :show]

  resources :orders, only: [:create] do
    resources :payments, only: [:new, :create]
  end

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      get 'translations/dictionnary', to: 'translations#dictionnary'
      post 'translations/translate', to: 'translations#translate'
      get 'shops/search', to: 'shops#search'

      resources :translations, only: [ :new ]
    end
  end
  # get '/style', to: 'pages#bootstrap_components'
  get '/clear-session', to: 'orders#clear_session_cart'
end
