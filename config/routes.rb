Rails.application.routes.draw do

  root 'pages#home'

  resources :assignments, only: [:show, :index] do
    resources :comments
  end

  resources :projects
  resources :assignments
  resources :programmers
end
