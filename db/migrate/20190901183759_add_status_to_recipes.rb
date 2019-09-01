class AddStatusToRecipes < ActiveRecord::Migration[6.0]
  def change
    add_column :recipes, :status, :integer, default: 0
  end
end
