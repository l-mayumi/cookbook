require 'rails_helper'

feature 'Admin creates cuisine' do
  scenario 'successfully' do
    User.create(email: 'admin@email.com', password: '123456', admin: true)
    
    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: 'admin@email.com'
    fill_in 'Senha', with: '123456'
    click_on 'Login'

    click_on 'Criar cozinha'
    fill_in 'Título', with: 'Indiana'
    click_on 'Enviar'

    expect(page).to have_css('h2', text: 'Indiana')
  end

  scenario 'and its name should be unique' do
    User.create(email: 'admin@email.com', password: '123456', admin: true)
    Cuisine.create(name: 'Indiana')
        
    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: 'admin@email.com'
    fill_in 'Senha', with: '123456'
    click_on 'Login'

    click_on 'Criar cozinha'
    fill_in 'Título', with: 'Indiana'
    click_on 'Enviar'

    expect(page).to have_content('Você deve informar um nome único')
  end

  scenario 'and should be an admin' do
    User.create(email: 'user@email.com', password: '123456')
        
    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: 'user@email.com'
    fill_in 'Senha', with: '123456'
    click_on 'Login'

    expect(page).not_to have_link('Criar cozinha')
  end

  scenario 'and cannot force route' do
        
    visit new_cuisine_path

    expect(page).to have_link('Entrar')
    expect(page).not_to have_css('h2', text: 'Cadastrar cozinha')
  end
end