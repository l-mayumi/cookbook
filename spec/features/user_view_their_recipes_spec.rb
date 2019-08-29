require 'rails_helper'

feature 'User view their recipes' do
  scenario 'successfully' do
    #cria os dados necessários
    user = User.create(email: 'user0@email.com', password: '123456')
    another_user = User.create(email: 'user1@email.com', password: '123456')
    recipe_type = RecipeType.create(name: 'Sobremesa')
    recipe = Recipe.create(title: 'Bolo de cenoura', recipe_type: recipe_type,
                           cuisine: 'Brasileira', difficulty: 'Médio',
                           cook_time: 60,
                           ingredients: 'Farinha, açucar, cenoura',
                           cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos,'\
                           ' misture com o restante dos ingredientes', user: user)

    another_recipe = Recipe.create(title: 'Bolo de chocolate', recipe_type: recipe_type,
                            cuisine: 'Brasileira', difficulty: 'Médio',
                            cook_time: 60,
                            ingredients: 'Farinha, açucar, chocolate',
                            cook_method: 'Corte o chocolate em pedaços pequenos,'\
                            ' misture com o restante dos ingredientes', user: another_user)

    # simula a ação do usuário
    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: 'user0@email.com'
    fill_in 'Senha', with: '123456'
    click_on 'Login'

    click_on 'Minhas Receitas'

    # expectativas do usuário após a ação
    expect(page).to have_css('h1', text: recipe.title)
    expect(page).not_to have_css('h1', text: another_recipe.title)
  end

  scenario 'and doesnt have any' do
    #cria os dados necessários
    user = User.create(email: 'user0@email.com', password: '123456')
    
    # simula a ação do usuário
    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: 'user0@email.com'
    fill_in 'Senha', with: '123456'
    click_on 'Login'

    click_on 'Minhas Receitas'

    # expectativas do usuário após a ação
    expect(page).to have_content('Você não tem receitas cadastradas ainda.')
  end
end
