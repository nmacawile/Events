Rails.application.routes.draw do
  
  resources :users, only: :show
  root "sessions#new"
  get "/signup" => "users#new"
  post "/signup" => "users#create"
  get "/signin" => "sessions#new"
  post "/signin" => "sessions#create"
  delete "/signout" => "sessions#destroy"
end
