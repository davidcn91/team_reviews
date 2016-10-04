Rails.application.routes.draw do
  devise_for :users, controllers: {registrations: 'members'}
  resources :teams do
    resources :reviews, except: [:show, :index]
  end

  resources :users

  namespace :api do
    namespace :v1 do
      resources :votes, only: [:index, :show, :update]
      resources :reviews, only: [:index, :show]
      resources :teams, only: [:index]
    end
  end

  root 'teams#index'
end
