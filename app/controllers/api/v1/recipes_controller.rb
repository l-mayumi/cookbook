class Api::V1::RecipesController < Api::V1::ApiController
  def create
    @recipe = Recipe.create(recipe_params)

    if @recipe.save
      render json: @recipe, status: 201
    else
      render json: { message: 'Erro ao salvar tipo de receita' }, status: 406
    end
  end


  def show 
    @recipe = Recipe.find(params[:id])

    render json: {recipe: @recipe}, except: %i[created_at updated_at], status: 202, include: {recipes: {except: %i[created_at updated_at]}}
    
  rescue ActiveRecord::RecordNotFound
    render json: {message: "ID inválido."}, status: 404
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    @recipe.destroy

    render json: @recipe, status: 200

  rescue ActiveRecord::RecordNotFound
    render json: { message: "ID inválido."}, status: 404
  end

  private

  def recipe_params
    params.require(:recipe).permit(:title, :difficulty, :recipe_type_id, :cuisine_id, :user_id, :recipe_photo, :cook_time, :cook_method, :ingredients, :status)
  end
end