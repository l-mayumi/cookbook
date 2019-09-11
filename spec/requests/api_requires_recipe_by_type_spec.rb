require 'rails_helper'

describe 'API gets recipes by type' do
  it 'successfully' do
    user = User.create(email: 'user0@email.com', password: '123456')
    recipe_type = RecipeType.create(name: 'Sobremesas')
    cuisine = Cuisine.create(name: 'Brasileira')
    file = fixture_file_upload("recipe.jpeg")
    recipe = Recipe.create(title: 'Bolo de cenoura', recipe_type: recipe_type,
                            cuisine: cuisine, difficulty: 'Médio',
                            cook_time: 60, recipe_photo: file,
                            ingredients: 'Farinha, açucar, cenoura',
                            cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos,'\
                            ' misture com o restante dos ingredientes', user: user, status: :approved)
    another_recipe = Recipe.create(title: 'Bolo de chocolate', recipe_type: recipe_type,
                            cuisine: cuisine, difficulty: 'Médio',
                            cook_time: 60, recipe_photo: file,
                            ingredients: 'Farinha, açucar, chocolate',
                            cook_method: 'Corte o chocolate em pedaços pequenos,'\
                            ' misture com o restante dos ingredientes', user: user, status: :approved)

    get '/api/v1/recipe_types/1'
    json_recipe_type = JSON.parse(response.body, symbolize_names: true)

    expect(response.status).to eq 202
    expect(json_recipe_type[:recipe_type][:name]).to include recipe_type.name
    expect(json_recipe_type[:recipe_type][:recipes][0][:title]).to include recipe.title
    expect(json_recipe_type[:recipe_type][:recipes][1][:title]).to include another_recipe.title
  end

  it 'and the recipe type ID is invalid' do
    get '/api/v1/recipe_types/1994'
    json_recipe_type = JSON.parse(response.body, symbolize_names: true)

    expect(response.status).to eq 404
    expect(json_recipe_type[:message]).to include "ID inválido."
  end
end