Rails.application.routes.draw do
  devise_for :users
  root to: 'recipes#index'

  resources :recipes, only: %i[index show new create edit update] do
    post 'add_to_list'
  end
  resources :recipe_types, only: %i[show new create]
  resources :recipe_lists, only: %i[show new create]

  get 'search', to: 'recipes#search'
  get 'user/my_recipes', to: 'users#my_recipes', as: 'my_recipes'
  get 'user/my_lists', to: 'users#my_lists', as: 'my_lists'
  get 'user/pending_recipes', to: 'users#pending_recipes', as: 'pending_recipes'
  post 'recipe_list/new', to: 'recipe_lists#new', as: 'new_list'
end