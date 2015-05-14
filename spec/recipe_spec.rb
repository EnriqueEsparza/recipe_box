require 'spec_helper'

describe Recipe do
  # it { should validate_presence_of(:title) }
  it { should have_and_belong_to_many(:ingredients)}
  # it 'ensures length of title is < 20 characters' do
  #   test_recipe = Recipe.new(title: "p" * 21)
  #   expect(test_recipe.save).to eq(false)
  # end
  #
  # it 'ensures presence of characters' do
  #   test_recipe = Recipe.new(title: "")
  #   expect(test_recipe.save).to eq(false)
  # end
end
