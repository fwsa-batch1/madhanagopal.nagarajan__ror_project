Rails.application.routes.draw do
  root to: "home#index"
  resources :users

  get "/signup" => "users#new", as: :signup
  get "/signin" => "session#new", as: :new_sessions
  post "/signin" => "session#create", as: :sessions
  delete "/signout" => "session#destroy", as: :destroy_sessions
end
