Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :users, only: [:show, :edit, :update, :index]

  resources :books do
  	resources :book_comments, only: [:create, :destroy]
  	resource :favorites, only: [:create, :destroy]
  end

  resources :relationships, only: [:create, :destroy]

  root 'home#index'
  get 'home/about' => 'home#about'

  get 'users/:id/follows' => 'relationships#follows'
  get 'users/:id/followers' => 'relationships#followers'
end
