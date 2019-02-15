class IngredientsController < ApplicationController
	def new
		@recipe = Recipe.find(params[:recipe_id])
		@groceries = Grocery.all.order(:grocery_name)
		@measurements = Measurement.all.order(:measurement_type, :measurement_name)
		@ingredient = Ingredient.new
	end
end
