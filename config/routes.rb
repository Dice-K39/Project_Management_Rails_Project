Rails.application.routes.draw do

  root 'pages#home'

  match '/auth/:provider/callback', to: 'sessions#login_by_github', via: [:get, :post]

  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'

  post '/logout' => 'sessions#destroy'

  resources :programmers

  resources :programmers do
    resources :assignments
  end

  resources :assignments do
    resources :comments
  end

  resources :projects
  resources :assignments
  
end
