require 'rails_helper'

RSpec.describe RecipeFood, type: :model do
  let(:recipe) { Recipe.create(name: 'Recipe') }
  let(:food) { Food.create(name: 'Food', measurement_unit: 'unit', quantity: 1, price: 1.0) }
  subject { described_class.new(recipe_id: recipe.id, food_id: food.id, quantity: 2) }

  context 'associations' do
    it 'belongs to recipe' do
      association = described_class.reflect_on_association(:recipe)
      expect(association.macro).to eq(:belongs_to)
    end

    it 'belongs to food' do
      association = described_class.reflect_on_association(:food)
      expect(association.macro).to eq(:belongs_to)
    end
  end

  context 'validations' do
    it 'is not valid without a quantity' do
      subject.quantity = nil
      expect(subject).to_not be_valid
    end
  end
end
