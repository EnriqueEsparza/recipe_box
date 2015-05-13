require 'spec_helper'

describe Recipe do
  it 'ensures length of title is < 50 characters' do
    test_recipe = Recipe.new(title: "P" * 51)
    expect(test_recipe.save).to eq(false)
  end
end
