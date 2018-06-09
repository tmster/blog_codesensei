Rails.application.routes.draw do
  devise_for :users
  root 'welcome#index'

  resources :articles do
    member do
      get :likes_summary
    end
    resources :comments, only: %i[create destroy]
    resources :likes, only: %i[create destroy]
  end

  namespace :admin do
    root 'articles#index'
    resources :articles, :comments
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
