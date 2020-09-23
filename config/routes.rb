Rails.application.routes.draw do

  root 'pages#home'

  resources :comments
  resources :projects
  resources :assignments
  resources :programmers
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
