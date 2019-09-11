require 'rails_helper'

describe 'API creates recipe type' do
  it 'successfully' do 
    recipe_type = {recipe_type: {name: 'Saladas'}}

    post api_v1_recipe_types_path(recipe_type)

    json_recipe_type = JSON.parse(response.body, symbolize_names: true)

    expect(response.status).to eq 201
    expect(json_recipe_type[:name]).to eq 'Saladas'
  end

  it 'and it cannot be empty' do 
    recipe_type = {recipe_type: {name: ''}}

    post api_v1_recipe_types_path(recipe_type)

    json_recipe_type = JSON.parse(response.body, symbolize_names: true)

    expect(response.status).to eq 404
    expect(json_recipe_type[:message]).to eq 'Erro ao salvar tipo de receita'
  end
end