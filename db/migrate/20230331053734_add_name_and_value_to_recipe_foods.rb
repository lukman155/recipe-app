class AddNameAndValueToRecipeFoods < ActiveRecord::Migration[7.0]
  def change
    add_column :recipe_foods, :name, :string
    add_column :recipe_foods, :value, :float
  end
end
