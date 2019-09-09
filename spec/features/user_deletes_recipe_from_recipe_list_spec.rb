require 'rails_helper'

feature 'User deletes recipe from recipe list' do
  scenario 'successfully' do
    user = User.create(email: 'user0@email.com', password: '123456')
    recipe_list = RecipeList.create(title: 'Bolos preferidos', user: user)
    recipe_type = RecipeType.create(name: 'Sobremesas')
    cuisine = Cuisine.create(name: 'Brasileira')
    file = fixture_file_upload("recipe.jpeg")
    recipe = Recipe.create(title: 'Bolo de cenoura', recipe_type: recipe_type,
                            cuisine: cuisine, difficulty: 'Médio',
                            cook_time: 60, recipe_photo: file,
                            ingredients: 'Farinha, açucar, cenoura',
                            cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos,'\
                            ' misture com o restante dos ingredientes', user: user)
    recipe_list_item = RecipeListItem.create(recipe: recipe, recipe_list: recipe_list)
    
    visit root_path
    click_on 'Entrar'

    fill_in 'Email', with: 'user0@email.com'
    fill_in 'Senha', with: '123456'
    click_on 'Login'
    
    click_on 'Minhas Listas'
    click_on 'Bolos preferidos'
    within(recipe_list_item.id)
        click_on 'Excluir'

    expect(page).not_to have_css('h4', text: 'Bolo de cenoura')
  end
end