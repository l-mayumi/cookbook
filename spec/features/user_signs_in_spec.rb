require 'rails_helper'

feature 'User signs in' do
    scenario 'successfully' do
        User.create(email: 'user0@email.com', password: '123456')

        visit root_path
        click_on 'Entrar'

        fill_in 'Email', with: 'user0@email.com'
        fill_in 'Senha', with: '123456'
        click_on 'Login'

        expect(page).to have_css('p', text: 'Ola, user0@email.com!')
        expect(page).to have_link('Sair')
        expect(page).not_to have_link('Entrar')
    end

    scenario 'and signs out' do
        User.create(email: 'user0@email.com', password: '123456')

        visit root_path
        click_on 'Entrar'

        fill_in 'Email', with: 'user0@email.com'
        fill_in 'Senha', with: '123456'
        click_on 'Login'

        click_on 'Sair'

        expect(page).to have_link('Entrar')
        expect(page).not_to have_link('Sair')
    end
end