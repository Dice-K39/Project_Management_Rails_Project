Rails.application.routes.draw do

  root 'pages#home'

  resources :assignments, only: [:show, :index] do
    resources :comments, only: [:index, :show, :new, :create, :edit]
  end

  resources :comments
  resources :projects
  resources :assignments
  resources :programmers
end
