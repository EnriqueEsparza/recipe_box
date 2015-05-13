require 'spec_helper'

describe Ingredient do
  describe '.recipes' do
    it "will return the ingredients of a particular recipe" do
      tomato = Ingredient.create(name: "Tomato")
      sauce = tomato.recipes.create(title: "pizza sauce")
      soup = tomato.recipes.create(title: "tomato soup")
      expect(tomato.recipes()).to eq([sauce, soup])
    end
  end
end
