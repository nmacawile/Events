Rails.application.routes.draw do
  
  resources :users, only: :show
  get "/signup" => "users#new"
  post "/signup" => "users#create"
end
