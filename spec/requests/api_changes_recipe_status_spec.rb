require 'rails_helper'

describe 'API changes recipe status' do
    it 'successfully' do 
        user = User.create(email: 'user0@email.com', password: '123456')
        recipe_type = RecipeType.create(name: 'Sobremesa')
        cuisine = Cuisine.create(name: 'Brasileira')
        recipe_photo = fixture_file_upload("recipe.jpeg")
        recipe = Recipe.create(title: 'Bolo de cenoura', recipe_type: recipe_type,
                               cuisine: cuisine, difficulty: 'Médio',
                               cook_time: 60, recipe_photo: recipe_photo,
                               ingredients: 'Farinha, açucar, cenoura',
                               cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos,'\
                               ' misture com o restante dos ingredientes', user: user)
    
        post "/api/v1/recipes/#{recipe.id}/approve"
    
        json_recipe = JSON.parse(response.body, symbolize_names: true)
    
        expect(response.status).to eq 202
        expect(json_recipe[:status]).to eq 'approved'
        
    end

    it 'and the recipe does not exist' do 
        post '/api/v1/recipes/1994/approve'
    
        json_recipe = JSON.parse(response.body, symbolize_names: true)
    
        expect(response.status).to eq 404
        expect(json_recipe[:message]).to eq 'ID inválido.'
        
    end
end