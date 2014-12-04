Rails.application.routes.draw do
  root "users#new"

  resources :users, only: [ :index, :show, :new, :create ]

  get "/login" => "users#login", as: "login"
  post "/sessions" => "sessions#login"
  delete "/sessions" => "sessions#logout", as: "logout"
end
