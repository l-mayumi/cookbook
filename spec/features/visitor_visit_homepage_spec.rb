require 'rails_helper'

feature 'Visitor visit homepage' do
  scenario 'successfully' do
    visit root_path

    expect(page).to have_css('h1', text: 'CookBook')
    expect(page).to have_css('p', text: 'Aqui você encontra as melhores receitas da internet. :)')
  end

  scenario 'and view recipe' do
    #cria os dados necessários
    user = User.create(email: 'user0@email.com', password: '123456')
    recipe_type = RecipeType.create(name: 'Sobremesa')
    cuisine = Cuisine.create(name: 'Brasileira')
    file = fixture_file_upload("recipe.jpeg")
    recipe = Recipe.create(title: 'Bolo de cenoura', difficulty: 'Médio',
                           recipe_type: recipe_type, cuisine: cuisine,
                           cook_time: 50, recipe_photo: file,
                           ingredients: 'Farinha, açucar, cenoura',
                           cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos,'\
                           ' misture com o restante dos ingredientes', user: user, status: :approved)

    # simula a ação do usuário
    visit root_path

    # expectativas do usuário após a ação
    expect(page).to have_css('h4', text: recipe.title)
    expect(page).to have_css('li', text: recipe.recipe_type.name)
    expect(page).to have_css('li', text: recipe.cuisine.name)
    expect(page).to have_css('li', text: recipe.difficulty)
    expect(page).to have_css('li', text: "#{recipe.cook_time} minutos")
  end

  scenario 'and view recipes list' do
    #cria os dados necessários
    user = User.create(email: 'user0@email.com', password: '123456')
    recipe_type = RecipeType.create(name: 'Sobremesa')
    another_recipe_type = RecipeType.create(name: 'Prato principal')
    cuisine = Cuisine.create(name: 'Brasileira')
    file = fixture_file_upload("recipe.jpeg")
    recipe = Recipe.create(title: 'Bolo de cenoura', recipe_type: recipe_type,
                           cuisine: cuisine, difficulty: 'Médio',
                           cook_time: 50, recipe_photo: file,
                           ingredients: 'Farinha, açucar, cenoura',
                           cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos,'\
                           ' misture com o restante dos ingredientes', user: user, status: :approved)

    another_recipe = Recipe.create(title: 'Feijoada', recipe_type: another_recipe_type,
                                   cuisine: cuisine, difficulty: 'Difícil',
                                   cook_time: 90, recipe_photo: file,
                                   ingredients: 'Feijão e carnes',
                                   cook_method: 'Misture o feijão com as carnes', user: user, status: :approved)

    # simula a ação do usuário
    visit root_path

    # expectativas do usuário após a ação
    expect(page).to have_css('h4', text: recipe.title)
    expect(page).to have_css('li', text: recipe.recipe_type.name)
    expect(page).to have_css('li', text: recipe.cuisine.name)
    expect(page).to have_css('li', text: recipe.difficulty)
    expect(page).to have_css('li', text: "#{recipe.cook_time} minutos")

    expect(page).to have_css('h4', text: another_recipe.title)
    expect(page).to have_css('li', text: another_recipe.recipe_type.name)
    expect(page).to have_css('li', text: another_recipe.cuisine.name)
    expect(page).to have_css('li', text: another_recipe.difficulty)
    expect(page).to have_css('li', text: "#{another_recipe.cook_time} minutos")
  end

  scenario 'and accesses all recipes' do
    #cria os dados necessários
    user = User.create(email: 'user0@email.com', password: '123456')
    recipe_type = RecipeType.create(name: 'Sobremesa')
    another_recipe_type = RecipeType.create(name: 'Prato principal')
    cuisine = Cuisine.create(name: 'Brasileira')
    file = fixture_file_upload("recipe.jpeg")
    recipe = Recipe.create(title: 'Bolo de cenoura', recipe_type: recipe_type,
                           cuisine: cuisine, difficulty: 'Médio',
                           cook_time: 50, recipe_photo: file,
                           ingredients: 'Farinha, açucar, cenoura',
                           cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos,'\
                           ' misture com o restante dos ingredientes', user: user, status: :approved)

    another_recipe = Recipe.create(title: 'Feijoada', recipe_type: another_recipe_type,
                                   cuisine: cuisine, difficulty: 'Difícil',
                                   cook_time: 90, recipe_photo: file,
                                   ingredients: 'Feijão e carnes',
                                   cook_method: 'Misture o feijão com as carnes', user: user, status: :approved)

    # simula a ação do usuário
    visit root_path
    click_on 'Todas as receitas'

    # expectativas do usuário após a ação
    expect(page).to have_css('h2', text: 'Todas as receitas')
    expect(page).to have_css('li', text: recipe.title)
    expect(page).to have_css('li', text: another_recipe.title)
  end
end
