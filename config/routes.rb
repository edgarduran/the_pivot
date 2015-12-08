Rails.application.routes.draw do
  get 'stores/new'

  get '/', to: 'home#home'
  get '/cart', to: 'cart#show'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get '/dashboard', to: 'users#show'
  get '/profile/:id', to: 'users#profile'

  resources :cart_cars, only: [:create, :destroy, :update]
  resources :cars, only: [:index, :show]
  resources :locations, only: [:show, :index], param: :slug
  resources :users, only: [:new, :create, :edit, :update]

  namespace :admin do
    resources :items, only: [:index, :show, :new, :create, :destroy]
    resources :dashboard, only: [:show, :index]
    resources :locations, only: [:show, :index], param: :slug
  end

  post '/admin/dashboard', to: 'admin/dashboard#daily_deal'
  resources :orders, only: [:index, :show, :create, :update]

  namespace :stores, path: ":store", as: :store do
    resources :cars, only: [:index, :show, :new, :update, :create]
    resources :dashboard, only: [:show]
  end

  resources :stores, only: [:new, :create, :index, :edit]
end
