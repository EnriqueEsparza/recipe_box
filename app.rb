require 'bundler/setup'
Bundler.require(:default)
require('pry')

Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }

get '/' do
  @recipes = Recipe.all
  @categories = Category.all
  erb(:index)
end

post '/' do
  @recipes = Recipe.all
  @categories = Category.all

  category_name = params.fetch("category")


  @recipe = Recipe.new(title: params.fetch("title"))
  if @recipe.save
    redirect to("/")
  else
    erb(:errors)
  end
end

get '/recipes/:id' do
  @recipe = Recipe.find(params.fetch("id").to_i)
  @ingredients = @recipe.ingredients
  @categories = Category.all
  erb(:recipe_info)
end

post '/recipes/:id' do
  @recipe = Recipe.find(params.fetch("id").to_i)
  @ingredient = @recipe.ingredients.create(name: params.fetch("name"))
  @ingredients = @recipe.ingredients
  erb(:recipe_info)
end

patch '/recipes/:id' do
  @recipe = Recipe.find(params.fetch("id").to_i)
  @instructions = params.fetch("instructions")
  @recipe.update(instructions: @instructions)
  @ingredients = @recipe.ingredients
  erb(:recipe_info)
end

patch '/recipes/:id/categories' do
  @categories = Category.all
  @recipe = Recipe.find(params.fetch("id").to_i)
  category_ids = params.fetch("category_ids")
  category_ids.each do |category_id|
    selected_category = Category.find(category_id)
    @recipe.categories.push(selected_category)
  end
  @ingredients = @recipe.ingredients
  erb(:recipe_info)
end

get '/categories/new' do
  erb(:categories)
end

post '/category' do
  Category.create(name: params.fetch("name"))
  @recipes = Recipe.all
  @categories = Category.all
  erb(:index)
end
