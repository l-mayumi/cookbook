class RemoveUserRefFromRecipeListItem < ActiveRecord::Migration[6.0]
  def change
    remove_reference :recipe_list_items, :user, foreign_key: true
  end
end
