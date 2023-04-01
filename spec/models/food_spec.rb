require 'rails_helper'

RSpec.describe Food, type: :model do
  context 'validations' do

    it 'is not valid without a name' do
      food = Food.new(name: nil, measurement_unit: 'kg', quantity: 1, price: 0.5)
      expect(food).to_not be_valid
      expect(food.errors.full_messages).to include("Name can't be blank")
    end

    it 'is not valid without a measurement unit' do
      food = Food.new(name: 'Potato', measurement_unit: nil, quantity: 1, price: 0.5)
      expect(food).to_not be_valid
      expect(food.errors.full_messages).to include("Measurement unit can't be blank")
    end

    it 'is not valid without a quantity' do
      food = Food.new(name: 'Potato', measurement_unit: 'kg', quantity: nil, price: 0.5)
      expect(food).to_not be_valid
      expect(food.errors.full_messages).to include("Quantity can't be blank")
    end

    it 'is not valid without a price' do
      food = Food.new(name: 'Potato', measurement_unit: 'kg', quantity: 1, price: nil)
      expect(food).to_not be_valid
      expect(food.errors.full_messages).to include("Price can't be blank")
    end
  end

  context 'associations' do
    it 'belongs to user' do
      assc = described_class.reflect_on_association(:user)
      expect(assc.macro).to eq :belongs_to
    end

    it 'has many recipe_foods' do
      assc = described_class.reflect_on_association(:recipe_foods)
      expect(assc.macro).to eq :has_many
      expect(assc.options[:dependent]).to eq :destroy
    end

    it 'has many recipes through recipe_foods' do
      assc = described_class.reflect_on_association(:recipes)
      expect(assc.macro).to eq :has_many
      expect(assc.options[:through]).to eq :recipe_foods
      expect(assc.options[:dependent]).to eq :destroy
    end
  end
end
