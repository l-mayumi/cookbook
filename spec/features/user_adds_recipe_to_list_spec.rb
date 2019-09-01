require 'rails_helper'

feature 'User adds recipe to list' do
  xscenario 'successfully' do
    user = User.create(email: 'user0@email.com', password: '123456')
    recipe_list = RecipeList.create(title: 'Bolos preferidos', user: user)
    recipe_type = RecipeType.create(name: 'Sobremesas')
    recipe = Recipe.create(title: 'Bolo de cenoura', recipe_type: recipe_type,
                            cuisine: 'Brasileira', difficulty: 'Médio',
                            cook_time: 60,
                            ingredients: 'Farinha, açucar, cenoura',
                            cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos,'\
                            ' misture com o restante dos ingredientes', user: user)
    
    # simula a ação do usuário
    visit root_path
    click_on 'Entrar'

    fill_in 'Email', with: 'user0@email.com'
    fill_in 'Senha', with: '123456'
    click_on 'Login'
    
    click_on 'Minhas Receitas'
    click_on 'Bolo de cenoura'
    select 'Bolos preferidos', from: 'Adicionar à lista'
    click_on 'Salvar'

    expect(page).to have_css('li', text: 'Bolos preferidos')
  end
end