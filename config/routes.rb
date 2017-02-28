Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :shops, only: [:index, :show]  do
  end
  get '/style', to: 'pages#bootstrap_components'
  get '/test', to: 'pages#test'

end
