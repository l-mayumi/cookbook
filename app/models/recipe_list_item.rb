class RecipeListItem < ApplicationRecord
  belongs_to :recipe_list
  belongs_to :recipe

  validates :recipe, presence: true, uniqueness: {scope: :recipe_list}
  validates :recipe_list, presence: true, uniqueness: {scope: :recipe}
end
