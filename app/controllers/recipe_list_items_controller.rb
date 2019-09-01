class RecipeListItemsController < ApplicationController
    def create
      @recipe_lists = RecipeList.where(user: current_user)
      @recipe = Recipe.find(params[:recipe_list_item][:recipe_id])
      @recipe_list_items = RecipeListItem.new(recipe: @recipe, recipe_list: @recipe_list)
      if @recipe_list_items.save
        redirect_to @recipe
      else
        flash[:alert] = 'Esta receita ja foi adicionado a esta lista'
        redirect_to @recipe
      end
    end
  
    def destroy
      @recipe_list = RecipeList.find(params[:id])
      @recipe = Recipe.find(params[:recipe_id])
      @recipe_list_items = RecipeListItem.where(recipe: @recipe, recipe_list: @recipe_list)
      RecipeListItem.delete(@recipe_list_items)
      flash[:alert] = "Receita #{@recipe.title} foi removida da lista"
      redirect_to @recipe_list
    end
  
    private
  
    def recipe_list_params
      params.require(:recipe_list).permit(:recipe, :list)
    end
  end