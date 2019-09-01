require 'rails_helper'

feature 'User register recipe lists' do
  scenario 'successfully' do
    User.create(email: 'user0@email.com', password: '123456')
    
    # simula a ação do usuário
    visit root_path
    click_on 'Entrar'

    fill_in 'Email', with: 'user0@email.com'
    fill_in 'Senha', with: '123456'
    click_on 'Login'
    
    click_on 'Minhas Listas'
    click_on 'Criar nova lista'

    fill_in 'Título', with: 'Festa de aniversario'
    click_on 'Criar lista'

    expect(page).to have_css('h2', text: 'Festa de aniversario')
  end

  scenario 'and views their lists' do
    user = User.create(email: 'user0@email.com', password: '123456')
    other_user = User.create(email: 'user1@email.com', password: '123456')
    RecipeList.create(title: 'Pudins', user: user)
    RecipeList.create(title: 'Tortas', user: user)
    RecipeList.create(title: 'Risotos', user: other_user)

    # simula a ação do usuário
    visit root_path
    click_on 'Entrar'

    fill_in 'Email', with: 'user0@email.com'
    fill_in 'Senha', with: '123456'
    click_on 'Login'
    
    click_on 'Minhas Listas'

    expect(page).to have_css('li', text: 'Pudins')
    expect(page).to have_css('li', text: 'Tortas')
    expect(page).not_to have_css('li', text: 'Risotos')
  end

  scenario 'and it should have an unique name' do
    user = User.create(email: 'user0@email.com', password: '123456')
    RecipeList.create(title: 'Pudins', user: user)

    # simula a ação do usuário
    visit root_path
    click_on 'Entrar'

    fill_in 'Email', with: 'user0@email.com'
    fill_in 'Senha', with: '123456'
    click_on 'Login'
    
    click_on 'Minhas Listas'
    click_on 'Criar nova lista'

    fill_in 'Título', with: 'Pudins'
    click_on 'Criar lista'

    expect(page).to have_content('Você deve informar um nome único')

  end


end