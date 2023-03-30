class Recipe < ApplicationRecord
  belongs_to :user
  has_many :recipe_foods, dependent: :destroy
  has_many :foods, through: :recipe_foods

  def total_price
    foods.sum('foods.price * foods.quantity')
  end
end
