Rails.application.routes.draw do

  root 'pages#home'

  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'

  get '/logout' => 'sessions#new'
  post '/logout' => 'sessions#destroy'

  resources :programmers do
    resources :assignments
  end

  resources :assignments, only: [:show, :index] do
    resources :comments
  end

  resources :projects
  resources :assignments
  resources :programmers
end
