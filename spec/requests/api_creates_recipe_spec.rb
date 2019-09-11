require 'rails_helper'

describe 'API creates recipe' do
  it 'successfully' do 
    User.create(email: 'user0@email.com', password: '123456')
    RecipeType.create(name: 'Sobremesa')
    Cuisine.create(name: 'Brasileira')
    recipe = {recipe: {title: 'Bolo de cenoura', recipe_type_id: 1,
                        difficulty: 'Médio', cuisine_id: 1,
                        cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
                        cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes',
                        user_id: '1'}}

    post api_v1_recipes_path(recipe)

    json_recipe = JSON.parse(response.body, symbolize_names: true)
    

    expect(response.status).to eq 201
    expect(json_recipe[:title]).to eq 'Bolo de cenoura'
    expect(json_recipe[:difficulty]).to eq 'Médio'
  end

  it 'and must fill in all fields' do 
    recipe = {recipe: {title: '', recipe_type_id: '',
                        difficulty: '', cuisine_id: '',
                        cook_time: 50, ingredients: '',
                        cook_method: '',
                        user_id: '1' }}

    post api_v1_recipes_path(recipe)

    json_recipe = JSON.parse(response.body, symbolize_names: true)

    expect(response.status).to eq 406
    expect(json_recipe[:message]).to eq 'Erro ao salvar tipo de receita'
  end

  it 'and it should have an unique name' do 
    user = User.create(email: 'user0@email.com', password: '123456')
    recipe_type = RecipeType.create(name: 'Sobremesa')
    cuisine = Cuisine.create(name: 'Brasileira')
    recipe_photo = fixture_file_upload("recipe.jpeg")
    Recipe.create(title: 'Bolo de cenoura', recipe_type: recipe_type,
                           cuisine: cuisine, difficulty: 'Médio',
                           cook_time: 60, recipe_photo: recipe_photo,
                           ingredients: 'Farinha, açucar, cenoura',
                           cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos,'\
                           ' misture com o restante dos ingredientes', user: user)
    recipe = {recipe: {title: 'Bolo de cenoura', recipe_type_id: 1,
                           difficulty: 'Médio', cuisine_id: 1,
                           cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
                           cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes',
                           user_id: '1'}}

    post api_v1_recipes_path(recipe)

    json_recipe = JSON.parse(response.body, symbolize_names: true)
    

    expect(response.status).to eq 406
    expect(json_recipe[:message]).to eq 'Erro ao salvar tipo de receita'
  end
end