class UsersController < ApplicationController
  before_action :authenticate_user!, only: %i[new create edit update my_recipes my_lists pending_recipes]

  def my_recipes
    @recipes = Recipe.where(user: current_user)
    flash.now[:failure] = 'Você não tem receitas cadastradas ainda.'
  end

  def my_lists
    @recipe_lists = RecipeList.where(user: current_user)
    flash.now[:failure] = 'Você não tem listas cadastradas ainda.'
  end

  def pending_recipes
    @recipes = Recipe.where(status: :pending, user: current_user)
    flash.now[:failure] = 'Você não tem receitas pendentes.'
  end
end