class AddUserRefToRecipeList < ActiveRecord::Migration[6.0]
  def change
    add_reference :recipe_lists, :user, foreign_key: true
  end
end
