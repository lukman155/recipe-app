require 'rails_helper'

RSpec.describe Recipe, type: :model do
  context 'validations' do
    it 'is not valid without a name' do
      recipe = Recipe.new(preparation_time: 10, cooking_time: 20, description: 'A test recipe description')
      expect(recipe).to_not be_valid
    end

    it 'is not valid without a preparation time' do
      recipe = Recipe.new(name: 'Test Recipe', cooking_time: 20, description: 'A test recipe description')
      expect(recipe).to_not be_valid
    end

    it 'is not valid without a cooking time' do
      recipe = Recipe.new(name: 'Test Recipe', preparation_time: 10, description: 'A test recipe description')
      expect(recipe).to_not be_valid
    end

    it 'is not valid without a description' do
      recipe = Recipe.new(name: 'Test Recipe', preparation_time: 10, cooking_time: 20)
      expect(recipe).to_not be_valid
    end
  end

  context 'associations' do
    it 'belongs to user' do
      assc = described_class.reflect_on_association(:user)
      expect(assc.macro).to eq :belongs_to
    end

    it 'has many recipe foods' do
      assc = described_class.reflect_on_association(:recipe_foods)
      expect(assc.macro).to eq :has_many
    end

    it 'has many foods' do
      assc = described_class.reflect_on_association(:foods)
      expect(assc.macro).to eq :has_many
    end
  end

  context 'methods' do
    describe '#total_cost' do
      it 'returns 0 when there are no recipe foods' do
        recipe = Recipe.new(name: 'Test Recipe', preparation_time: 10, cooking_time: 20,
                            description: 'A test recipe description')
        expect(recipe.total_cost).to eq 0
      end
    end
  end
end
