Rails.application.routes.draw do
  devise_for :users, controllers: {registrations: 'members'}
  resources :teams do
    resources :reviews
  end

  resources :users

  namespace :api do
    namespace :v1 do
      resources :votes
      resources :reviews
      resources :teams
    end
  end

  root 'teams#index'
end
