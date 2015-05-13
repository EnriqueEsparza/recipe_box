class Recipe < ActiveRecord::Base
  has_and_belongs_to_many(:categories)
  has_and_belongs_to_many(:ingredients)
  validates(:title, {:presence => true, :length => {:maximum => 20}})
end
