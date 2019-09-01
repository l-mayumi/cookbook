class Recipe < ApplicationRecord
  belongs_to :recipe_type
  belongs_to :cuisine
  belongs_to :user
  has_many :recipe_list_items
  
  validates :title, :recipe_type_id, :cuisine_id, :difficulty, :cook_time, :ingredients, :cook_method, presence: true
  validates :title, uniqueness: true

  enum status: { pending: 0, approved: 5, rejected: 10 }

  def cook_time_min
    "#{cook_time} minutos"
  end
end
