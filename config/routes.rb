Rails.application.routes.draw do
  root 'welcome#index'
  get 'articles', to: 'articles#index'
  get 'articles/new', to: 'articles#new', as: 'new_article'
  post 'articles', to: 'articles#create'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
