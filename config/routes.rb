Rails.application.routes.draw do
  root "events#index"
  resources :attendances, only: :create
  resources :events do
    resources :invites, only: [:new, :create]
  end
  resources :users, only: [:show, :index]
  get "/signup" => "users#new"
  post "/signup" => "users#create"
  get "/signin" => "sessions#new"
  post "/signin" => "sessions#create"
  delete "/signout" => "sessions#destroy"
end
