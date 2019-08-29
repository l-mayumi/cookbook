class UsersController < ApplicationController
  def my_recipes
    @recipes = Recipe.where(user: current_user)
    flash.now[:failure] = 'Você não tem receitas cadastradas ainda.'
  end

  def my_lists
    @recipe_lists = RecipeList.where(user: current_user)
    flash.now[:failure] = 'Você não tem listas cadastradas ainda.'
  end
end