class Api::V1::RecipeTypesController < Api::V1::ApiController
  def create
    @recipe_type = RecipeType.create(recipe_type_params)

    if @recipe_type.save
      render json: @recipe_type, status: 201
    else
      render json: { message: 'Erro ao salvar tipo de receita' }, status: 406
    end
  end


  def show 
    @recipe_type = RecipeType.find(params[:id])
    @recipes = @recipe_type.recipes

    render json: {recipe_type: @recipe_type}, except: %i[created_at updated_at], status: 202, include: {recipes: {except: %i[created_at updated_at]}}
    
    rescue ActiveRecord::RecordNotFound
      render json: {message: "ID inválido."}, status: 404
  end

  private

  def recipe_type_params
    params.require(:recipe_type).permit(:name)
  end
end