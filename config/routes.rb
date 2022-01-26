Rails.application.routes.draw do
  # get 'sessions/new'
  # get 'users/new'
  get '/help', to: 'static_pages#help'
  get '/about', to: 'static_pages#about'
  get '/contact', to: 'static_pages#contact'
  get '/signup', to: 'users#new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.
  root 'static_pages#home'
  resources :users do
    member do
      get :following, :followers
      # Adding following and followers actions look like : /users/1/following or /users/1/followers
    end
  end
  resources :account_activations, only: [:edit]
  resources :microposts, only: [:create, :destroy]
  resources :relationships, only: [:create, :destroy] # Adding the routes for user relationships.
end
