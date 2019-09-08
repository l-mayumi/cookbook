class RecipeListItemsController < ApplicationController

  def create
    @recipe_list = RecipeList.find(params[:recipe_list_item][:recipe_list_id])
    @recipe = Recipe.find(params[:recipe_list_item][:recipe_id])
    @recipe_list_item = RecipeListItem.create(recipe: @recipe, recipe_list: @recipe_list)
    if @recipe_list_item.save
      flash[:failure] = 'Receita adicionada com sucesso'
      redirect_to @recipe
    else
      flash[:failure] = 'Esta receita já foi adicionada a esta lista'
      redirect_to @recipe
    end
  end

  def destroy
    @recipe_list = RecipeList.find(params[:id])
    @recipe = Recipe.find(params[:recipe_id])
    @recipe_list_item = RecipeListItem.where(recipe: @recipe, recipe_list: @recipe_list)
    RecipeListItem.delete(@recipe_list_item)
    flash[:alert] = "Receita #{@recipe.title} foi removida da lista"
    redirect_to @recipe_list
  end
end