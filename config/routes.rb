Rails.application.routes.draw do
  root to: 'sessions#index'
  resources :sessions, only: :index

  get "/logout" => 'sessions#destroy', as: :logout
  get "/auth/:provider/callback" => 'sessions#create'
end
