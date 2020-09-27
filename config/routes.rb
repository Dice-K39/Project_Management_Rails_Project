Rails.application.routes.draw do

  root 'pages#home'

  resources :comments
  resources :projects
  resources :assignments
  resources :programmers

  resources :assignments, only: [:show, :index] do
    resources :comments, only: [:show, :index, :new, :edit]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
