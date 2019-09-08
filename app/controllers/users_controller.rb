class UsersController < ApplicationController
  before_action :authenticate_user!, only: %i[new create edit update my_recipes my_lists pending_recipes]
  before_action :verify_admin, only: %i[approved rejected]

  def my_recipes
    @recipes = Recipe.where(user: current_user)
    flash.now[:failure] = 'Você não tem receitas cadastradas ainda.'
  end

  def my_lists
    @recipe_lists = RecipeList.where(user: current_user)
    flash.now[:failure] = 'Você não tem listas cadastradas ainda.'
  end

  def pending_recipes
    if current_user.admin?
      @recipes = Recipe.where(status: :pending)
    else
      @recipes = Recipe.where(status: :pending, user: current_user)
    end
    flash.now[:failure] = 'Você não tem receitas pendentes.'
  end

  def approve_recipe
    Recipe.find(params[:id]).approved!
    flash[:notice] = 'Receita aprovada com sucesso'
    redirect_to pending_recipes_path
  end

  def reject_recipe
    Recipe.find(params[:id]).rejected!
    flash[:notice] = 'Receita rejeitada com sucesso'
    redirect_to pending_recipes_path
  end

  private

  def verify_admin
    redirect_to root_path unless current_user.admin?
  end
end