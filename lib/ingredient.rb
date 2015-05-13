class Ingredient < ActiveRecord::Base
  has_and_belongs_to_many(:recipes)
  validates(:name, {:presence => true, :length => {:maximum => 50}})
end
