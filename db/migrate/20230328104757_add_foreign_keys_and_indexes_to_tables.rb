class AddForeignKeysAndIndexesToTables < ActiveRecord::Migration[7.0]
  def change
    add_reference :foods, :recipe_food, null: false, foreign_key: true unless column_exists?(:foods, :recipe_food_id)
    add_reference :recipe_foods, :recipe, null: false, foreign_key: true unless column_exists?(:recipe_foods, :recipe_id)
    add_reference :recipe_foods, :food, null: false, foreign_key: true unless column_exists?(:recipe_foods, :food_id)
    add_reference :recipes, :user, null: false, foreign_key: true unless column_exists?(:recipes, :user_id)
    add_index :recipe_foods, [:recipe_id, :food_id], unique: true unless index_exists?(:recipe_foods, [:recipe_id, :food_id])
  end
end
