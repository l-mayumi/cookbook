class Api::V1::RecipeTypesController < Api::V1::ApiController
  def show 
    @recipe_type = RecipeType.find(params[:id])
    @recipes = @recipe_type.recipes

    render json: {recipe_type: @recipe_type}, except: %i[created_at updated_at], status: 202, include: {recipes: {except: %i[created_at updated_at]}}
    
    rescue ActiveRecord::RecordNotFound
      render json: {message: "ID inválido."}, status: 404
  end
end