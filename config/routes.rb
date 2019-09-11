Rails.application.routes.draw do
  devise_for :users
  root to: 'recipes#index'
  get 'search', to: 'recipes#search'

  resources :recipes, only: %i[index show new create edit update approved rejected]

  resources :recipe_types, only: %i[show new create]
  resources :cuisines, only: %i[show new create]
  resources :recipe_lists, only: %i[show new create]
  resources :recipe_list_items, only: %i[create]
  
  get 'my_recipes', to: 'users#my_recipes'
  get 'my_lists', to: 'users#my_lists'
  get 'pending_recipes', to: 'users#pending_recipes'
  get 'recipe/:id/reject', to: 'users#reject_recipe', as: 'reject_recipe'
  get 'recipe/:id/approve', to: 'users#approve_recipe', as: 'approve_recipe'
  get 'all_recipes', to: 'recipes#all_recipes'
  delete 'recipe_list/:id/recipe/(.:recipe_id)', to: 'recipe_list_items#destroy', as: 'remove_from_list'

  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
      resources :recipe_types, only: %i[show create]
      resources :recipes, only: %i[index show]
    end
  end
end