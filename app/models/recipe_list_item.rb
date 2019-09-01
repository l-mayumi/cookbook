class RecipeListItem < ApplicationRecord
  belongs_to :recipe_list
  belongs_to :recipe

  validates :recipe, uniqueness: true
end
