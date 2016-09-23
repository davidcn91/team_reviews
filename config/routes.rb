Rails.application.routes.draw do
  devise_for :users
  resources :teams do
    resources :reviews
  end
  resources :users

  root 'teams#index'
end
