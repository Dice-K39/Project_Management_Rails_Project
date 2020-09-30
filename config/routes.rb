Rails.application.routes.draw do

  root 'pages#home'

  match '/auth/:provider/callback', to: 'sessions#login_by_github', via: [:get, :post]

  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'

  post '/logout' => 'sessions#destroy'

  resources :sessions, only: [:new, :create, :destroy]

  resources :programmers
  resources :projects

  resources :assignments do
    resources :comments
  end  
end
