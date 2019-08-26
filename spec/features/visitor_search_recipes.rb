require 'rails_helper'

feature 'Visitor searches for recipe' do
  scenario 'with exact name and finds it' do
    recipe_type = RecipeType.create(name: 'Sobremesa')
    recipe = Recipe.create(title: 'Bolo de cenoura', difficulty: 'Médio',
                  recipe_type: recipe_type, cuisine: 'Brasileira',
                  cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
                  cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes')
    another_recipe = Recipe.create(title: 'Bolo de chocolate', difficulty: 'Médio',
                  recipe_type: recipe_type, cuisine: 'Brasileira',
                  cook_time: 50, ingredients: 'Farinha, açucar, chocolate',
                  cook_method: 'Corte o chocolate em pedaços pequenos, misture com o restante dos ingredientes')

    visit root_path

    fill_in 'Buscar receita', with: 'Bolo de cenoura'
    click_on 'Buscar'

    expect(page).to have_css('li', text: 'Bolo de cenoura')
    expect(page).not_to have_css('li', text: 'Bolo de chocolate')

  end

  scenario 'with exact name and does not find it' do
    recipe_type = RecipeType.create(name: 'Sobremesa')
    recipe = Recipe.create(title: 'Bolo de cenoura', difficulty: 'Médio',
                  recipe_type: recipe_type, cuisine: 'Brasileira',
                  cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
                  cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes')
    
    visit root_path

    fill_in 'Buscar receita', with: 'Bolo de chocolate'
    click_on 'Buscar'

    expect(page).not_to have_css('li', text: 'Bolo de cenoura')
    expect(page).not_to have_css('li', text: 'Bolo de chocolate')

  end

  scenario 'with partial name and finds more than one' do
    recipe_type = RecipeType.create(name: 'Sobremesa')
    recipe = Recipe.create(title: 'Bolo de cenoura', difficulty: 'Médio',
                  recipe_type: recipe_type, cuisine: 'Brasileira',
                  cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
                  cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes')
    another_recipe = Recipe.create(title: 'Bolo de chocolate', difficulty: 'Médio',
                  recipe_type: recipe_type, cuisine: 'Brasileira',
                  cook_time: 50, ingredients: 'Farinha, açucar, chocolate',
                  cook_method: 'Corte o chocolate em pedaços pequenos, misture com o restante dos ingredientes')
    
    visit root_path

    fill_in 'Buscar receita', with: 'Bolo'
    click_on 'Buscar'

    expect(page).to have_css('li', text: 'Bolo de cenoura')
    expect(page).to have_css('li', text: 'Bolo de chocolate')

  end
end
