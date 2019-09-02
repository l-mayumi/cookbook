require 'rails_helper'

feature 'Admin approved recipes' do
  scenario 'successfully' do
    user = User.create!(email: 'user@email.com', password: '123456')
    admin = User.create!(email: 'admin@email.com', password: '123456', admin: true)
    recipe_type = RecipeType.create(name: 'Sobremesa')
    cuisine = Cuisine.create(name: 'Brasileira')
    file = fixture_file_upload("recipe.jpeg")
    recipe = Recipe.create(title: 'Bolo de cenoura', difficulty: 'Médio', user: user,
                           recipe_type: recipe_type, cuisine: cuisine,
                           cook_time: 50, recipe_photo: file,
                           ingredients: 'Farinha, açucar, cenoura',
                           cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos,'\
                           ' misture com o restante dos ingredientes')


    visit root_path
    click_on 'Entrar'
    
    fill_in 'Email', with: 'admin@email.com'
    fill_in 'Senha', with: '123456'
    click_on 'Login'
    
    click_on 'Receitas pendentes'
    click_on 'Bolo de cenoura'
    click_on 'Aprovar'
    recipe.reload

    #assert
    expect(current_path).to eq pending_recipes_path
    expect(page).to have_content('Receita aprovada com sucesso')
    expect(recipe.approved?).to eq true
  end

  scenario 'then rejects it' do
    user = User.create!(email: 'user@email.com', password: '123456')
    admin = User.create!(email: 'admin@email.com', password: '123456', admin: true)
    recipe_type = RecipeType.create(name: 'Sobremesa')
    cuisine = Cuisine.create(name: 'Brasileira')
    file = fixture_file_upload("recipe.jpeg")
    recipe = Recipe.create(title: 'Bolo de cenoura', difficulty: 'Médio', user: user,
                           recipe_type: recipe_type, cuisine: cuisine,
                           cook_time: 50, recipe_photo: file,
                           ingredients: 'Farinha, açucar, cenoura',
                           cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos,'\
                           ' misture com o restante dos ingredientes')


    visit root_path
    click_on 'Entrar'
    
    fill_in 'Email', with: 'admin@email.com'
    fill_in 'Senha', with: '123456'
    click_on 'Login'
    
    click_on 'Receitas pendentes'
    click_on 'Bolo de cenoura'
    click_on 'Rejeitar'
    recipe.reload

    #assert
    expect(current_path).to eq pending_recipes_path
    expect(page).to have_content('Receita rejeitada com sucesso')
    expect(recipe.rejected?).to eq true
  end
end