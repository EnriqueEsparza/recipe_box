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
  @categories = Category.all
  @recipe = Recipe.find(params.fetch("id").to_i)
  @ingredient = @recipe.ingredients.create(name: params.fetch("name"))
  @ingredients = @recipe.ingredients
  erb(:recipe_info)
end

patch '/recipes/:id' do
  @categories = Category.all
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

get '/recipes/:id/rating' do
  @recipe = Recipe.find(params.fetch("id").to_i)
  @ingredients = @recipe.ingredients
  @categories = Category.all
  erb(:recipe_info)
end

patch '/recipes/:id/rating' do
  @recipe = Recipe.find(params.fetch("id").to_i)
  rating = params.fetch("rating").to_i
  @recipe.update(rating: rating)
  redirect to "/recipes/#{@recipe.id}"
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

get '/view_categories' do
  @categories=Category.all
  erb(:view_categories)
end

get '/view_categories/:id' do
  @category = Category.find(params.fetch("id").to_i)

  erb(:view_categories_recipes)
end

delete '/:id/delete' do
  @recipe = Recipe.find(params.fetch("id").to_i)
  @recipe.ingredients.each do |ingredient|
    ingredient.delete
  end
  @recipe.delete
  redirect to '/'
end

delete '/view_categories' do
  @categories = Category.all()
  category = Category.find(params.fetch("categories_id").to_i)
  category.delete
  redirect to '/view_categories'
end

get '/ratings' do
  @recipes = Recipe.all
  erb(:ratings)
end
