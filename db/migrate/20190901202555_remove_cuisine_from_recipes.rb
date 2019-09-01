class RemoveCuisineFromRecipes < ActiveRecord::Migration[6.0]
  def change

    remove_column :recipes, :cuisine, :string
  end
end
