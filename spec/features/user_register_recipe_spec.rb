require 'rails_helper'

feature 'User register recipe' do
  scenario 'successfully' do
    #cria os dados necessários, nesse caso não vamos criar dados no banco
    User.create(email: 'user0@email.com', password: '123456')
    RecipeType.create(name: 'Entrada')

    # simula a ação do usuário
    visit root_path
    click_on 'Entrar'

    fill_in 'Email', with: 'user0@email.com'
    fill_in 'Senha', with: '123456'
    click_on 'Login'
    
    click_on 'Enviar uma receita'

    fill_in 'Título', with: 'Tabule'
    select 'Entrada', from: 'Tipo da Receita'
    fill_in 'Cozinha', with: 'Arabe'
    fill_in 'Dificuldade', with: 'Fácil'
    fill_in 'Tempo de Preparo', with: '45'
    fill_in 'Ingredientes', with: 'Trigo para quibe, cebola, tomate picado, azeite, salsinha'
    fill_in 'Como Preparar', with: 'Misturar tudo e servir. Adicione limão a gosto.'
    click_on 'Enviar'
    click_on 'Receitas pendentes'


    # expectativas
    expect(page).to have_css('li', text: 'Tabule')
  end

  scenario 'and must fill in all fields' do
    # simula a ação do usuário
    User.create(email: 'user0@email.com', password: '123456')
    visit root_path
    click_on 'Entrar'

    fill_in 'Email', with: 'user0@email.com'
    fill_in 'Senha', with: '123456'
    click_on 'Login'

    click_on 'Enviar uma receita'

    fill_in 'Título', with: ''
    fill_in 'Cozinha', with: ''
    fill_in 'Dificuldade', with: ''
    fill_in 'Tempo de Preparo', with: ''
    fill_in 'Ingredientes', with: ''
    fill_in 'Como Preparar', with: ''
    click_on 'Enviar'

    expect(page).to have_content('Não foi possível salvar a receita')
  end

  scenario 'and only approved recipes show up' do
    #cria os dados necessários, nesse caso não vamos criar dados no banco
    user = User.create(email: 'user0@email.com', password: '123456')
    recipe_type = RecipeType.create(name: 'Sobremesa')
    Recipe.create(title: 'Bolo de cenoura', recipe_type: recipe_type,
                  difficulty: 'Médio', cuisine: 'Brasileira',
                  cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
                  cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes',
                  user: user, status: :approved)
    Recipe.create(title: 'Bolo de laranja', recipe_type: recipe_type,
                    difficulty: 'Médio', cuisine: 'Brasileira',
                    cook_time: 50, ingredients: 'Farinha, açucar, laranja',
                    cook_method: 'Corte a laranja em pedaços pequenos, misture com o restante dos ingredientes',
                    user: user, status: :pending)
    Recipe.create(title: 'Bolo de chocolate', recipe_type: recipe_type,
                      difficulty: 'Médio', cuisine: 'Brasileira',
                      cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
                      cook_method: 'Corte o chocolate em pedaços pequenos, misture com o restante dos ingredientes',
                      user: user, status: :rejected)

    # simula a ação do usuário
    visit root_path
    click_on 'Entrar'

    fill_in 'Email', with: 'user0@email.com'
    fill_in 'Senha', with: '123456'
    click_on 'Login'

    # expectativas
    expect(page).to have_css('h1', text: 'Bolo de cenoura')
    expect(page).not_to have_css('h1', text: 'Bolo de laranja')
    expect(page).not_to have_css('h1', text: 'Bolo de chocolate')
  end
end
