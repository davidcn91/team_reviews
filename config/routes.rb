Rails.application.routes.draw do
  devise_for :users
  resources :teams do
    resources :reviews
  end

  root 'teams#index'
end
