require 'bundler/setup'
Bundler.require(:default)

Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }

get '/' do
  @recipes = Recipe.all
  erb(:index)
end
post '/' do
  @recipes = Recipe.all
  Recipe.create(title: params.fetch("title"))
  erb(:index)
end

get '/recipes/:id' do
  @recipe = Recipe.find(params.fetch("id").to_i)
  erb(:recipe_info)
end
