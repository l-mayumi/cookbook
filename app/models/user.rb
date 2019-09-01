class User < ApplicationRecord
  has_many :recipes
  has_many :recipe_lists 

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

end
