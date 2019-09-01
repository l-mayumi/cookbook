class RecipeTypesController < ApplicationController
  before_action :verify_admin, only: %i[new create edit update]

  def show
    @recipe_type = RecipeType.find(params[:id])
  end

  def new
    @recipe_type = RecipeType.new
  end

  def create
    @recipe_type = RecipeType.create(params.require(:recipe_type).permit(:name))
    if @recipe_type.save
      redirect_to @recipe_type
    else
      flash[:alert] = 'Você deve informar o nome do tipo de receita'
      render :new
    end
  end

  private

  def verify_admin
    redirect_to root_path unless current_user.admin?
  end
end