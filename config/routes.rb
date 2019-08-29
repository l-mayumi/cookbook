Rails.application.routes.draw do
  devise_for :users
  root to: 'recipes#index'

  resources :recipes, only: %i[index show new create edit update]
  resources :recipe_types, only: %i[show new create]

  get 'search', to: 'recipes#search'
  get 'user/my_recipes', to: 'users#my_recipes', as: 'my_recipes'
end