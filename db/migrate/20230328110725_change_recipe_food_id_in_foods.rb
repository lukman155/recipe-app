class ChangeRecipeFoodIdInFoods < ActiveRecord::Migration[7.0]
  def change
    change_column :foods, :recipe_food_id, :bigint, null: true
  end
end
