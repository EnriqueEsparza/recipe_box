require 'spec_helper'

describe Category do
  describe '.recipes' do
    it 'will return the recipes for that particular category' do
      breakfast = Category.create(name: "Breakfast")
      eggs = breakfast.recipes.create(title: "scrambled eggs")
      cereal = breakfast.recipes.create(title: "cereal")
      expect(breakfast.recipes()).to eq([eggs, cereal])
    end
  end
end
