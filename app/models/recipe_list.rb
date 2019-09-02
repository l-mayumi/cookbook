class RecipeList < ApplicationRecord
  has_many :recipe_list_items
  has_many :recipes, through: :recipe_list_items
  belongs_to :user

  validates :title, presence: true, uniqueness: true
end
