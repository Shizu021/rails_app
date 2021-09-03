Rails.application.routes.draw do
  devise_for :users
  resources :users, only: [:show]
  resources :relationships, only: [:create, :destroy]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :posts do
    resources :likes, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy]
  end

  

  root 'posts#index'
  
end
