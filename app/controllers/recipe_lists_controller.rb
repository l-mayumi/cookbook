class RecipeListsController < ApplicationController
  before_action :authenticate_user!, only: %i[new create edit update]

  def show
    @recipe_list = RecipeList.find(params[:id])
    @recipe_list_item = @recipe_list.recipe_list_items
  end

  def new
    @recipe_list = RecipeList.new
  end

  def create
    @recipe_list = RecipeList.new(params.require(:recipe_list).permit(:title))
    @recipe_list.user = current_user
    if @recipe_list.save
      redirect_to @recipe_list
    else
      flash[:alert] = 'Você deve informar um nome único'
      render :new
    end
  end
end