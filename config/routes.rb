Rails.application.routes.draw do
  root "welcome#index"

  resources :users, only: [ :index, :show, :new, :create ]

  get '/api/users' => "user_api#index"
  get '/api/users/:id' => "user_api#show"
  get '/api/users/:id/instagram_posts' => "user_api#instagram_posts"

  get "/login" => "users#login", as: "login"
  post "/sessions" => "sessions#login"
  delete "/sessions" => "sessions#logout", as: "logout"

end
