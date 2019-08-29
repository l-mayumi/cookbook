class AddRecipeListRefToRecipeListItems < ActiveRecord::Migration[6.0]
  def change
    add_reference :recipe_list_items, :recipe_list, foreign_key: true
  end
end
