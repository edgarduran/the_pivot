Rails.application.routes.draw do
  get '/', to: 'home#home'
  get '/cart', to: 'cart#show'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  resources :cart_cars, only: [:create, :destroy, :update]
  resources :cars, only: [:index, :show]
  resources :categories, only: [:show, :index], param: :slug
  resources :users, only: [:new, :create, :show, :edit, :update]
  namespace :admin do
    resources :items, only: [:index, :show, :new, :create, :destroy]
    resources :dashboard, only: [:show, :index]
    resources :categories, only: [:show, :index], param: :slug
  end
  post '/admin/dashboard', to: 'admin/dashboard#daily_deal'
  resources :orders, only: [:index, :show, :create, :update]

  namespace :stores, path: ":store", as: :store do
    resources :cars, only: [:index]
  end
end
