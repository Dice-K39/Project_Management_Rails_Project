Rails.application.routes.draw do

  root 'pages#home'

  match '/auth/:provider/callback' => 'sessions#create_or_login_by_github', via: [:get, :post]

  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'

  post '/logout' => 'sessions#destroy'

  resources :sessions, only: [:new, :create, :destroy]

  resources :programmers
  resources :projects

  # post '/assignments/:id' => 'assignments#update'

  resources :assignments do
    resources :comments
  end  
end
