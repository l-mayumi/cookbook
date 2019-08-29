require 'rails_helper'

feature 'User register recipe lists' do
  scenario 'successfully' do
    User.create(email: 'user0@email.com', password: '123456')
    RecipeType.create(name: 'Sobremesa')
    RecipeType.create(name: 'Entrada')

    # simula a ação do usuário
    visit root_path
    click_on 'Entrar'

    fill_in 'Email', with: 'user0@email.com'
    fill_in 'Senha', with: '123456'
    click_on 'Login'
    
    click_on 'Minhas Listas'
    click_on 'Criar nova lista'

    fill_in 'Titulo', with: 'Festa de aniversario'
    click_on 'Criar lista'

    expect(page).to have_css('li', text: 'Festa de aniversario')
  end
end