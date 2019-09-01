class RecipesController < ApplicationController
  before_action :authenticate_user!, only: %i[new create edit update]

  def index
  	@recipes = Recipe.where(status: :approved)
    @recipe_types = RecipeType.all
  end

  def show
    @recipe = Recipe.find(params[:id])
    @user = current_user
    @recipe_lists = RecipeList.where(user: current_user)
  end

  def new
    @recipe = Recipe.new
    @recipe_types = RecipeType.all
    @recipe_lists = RecipeList.where(user: current_user)
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.user = current_user
    if @recipe.save
      redirect_to @recipe
    else
      flash[:alert] = 'Não foi possível salvar a receita'
      @recipe_types = RecipeType.all
      @recipe_lists = RecipeList.where(user: current_user)
      render :new
    end
  end

  def edit
    @recipe = Recipe.find(params[:id])
    @recipe_types = RecipeType.all
    @recipe_lists = RecipeList.where(user: current_user)
  end

  def update
    @recipe = Recipe.find(params[:id])
    
    if @recipe.update(recipe_params)
      redirect_to @recipe
    else
      flash[:alert] = 'Não foi possível salvar a receita'
      @recipe_types = RecipeType.all
      @recipe_lists = RecipeList.where(user: current_user)
      render :edit
    end
  end

  def search
    @recipes = Recipe.where("title LIKE ?", "%#{params[:busca]}%")
  end

  def add_to_list
    @recipe = Recipe.find(params[:id])
    
    @recipe_list_item = RecipeListItem.new(params.require(:recipe_list_item).permit(:recipe_list_id))
    @recipe_list_item.recipe = @recipe

    if @recipe_list_item.save
      flash[:notice]
    else
      flash[:alert] = 'Erro ao salvar lista'
    end
    redirect_to @recipe
  end

  def pending
    @recipes = Recipe.pending
  end

  def approved
    Recipe.find(params[:id]).approved!
    flash[:notice] = 'Receita aprovada com sucesso'
    redirect_to pending_recipes_path
  end

  def rejected
    Recipe.find(params[:id]).rejected!
    flash[:notice] = 'Receita rejeitada com sucesso'
    redirect_to pending_recipes_path
  end


  private

  def recipe_params
    params.require(:recipe).permit(:title, :recipe_type_id, :cuisine, :difficulty, :cook_time, :ingredients, :cook_method)
  end
end
