class AddRefToRecipeListItem < ActiveRecord::Migration[6.0]
  def change
    add_reference :recipe_list_items, :user, foreign_key: true
    add_reference :recipe_list_items, :recipe, foreign_key: true
  end
end
