require 'rails_helper'

RSpec.describe User, type: :model do
  context 'validations' do
    it 'is valid with valid attributes' do
      user = User.new(email: 'user@example.com', password: 'password', password_confirmation: 'password')
      expect(user).to be_valid
    end

    it 'is invalid without an email' do
      user = User.new(password: 'password', password_confirmation: 'password')
      expect(user).to_not be_valid
    end
  end

  context 'associations' do
    it 'has many recipes' do
      assc = described_class.reflect_on_association(:recipes)
      expect(assc.macro).to eq :has_many
    end

    it 'has many foods' do
      assc = described_class.reflect_on_association(:foods)
      expect(assc.macro).to eq :has_many
    end
  end
end
