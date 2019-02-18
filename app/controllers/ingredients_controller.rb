class IngredientsController < ApplicationController
	before_action only: [:new, :create] do
		authorize_recipe_owner(params[:recipe_id])
	end

	def new
		@recipe = Recipe.find(params[:recipe_id])
		@grocery_types = Grocery.grocery_types
		@groceries = Grocery.where(grocery_type: @grocery_types.first).order(:grocery_name).pluck(:grocery_name, :id)
		@grocery_type = @grocery_types.first
		@measurement_types = Measurement.measurement_types
		@measurement_type = @measurement_types.first
		@measurements = Measurement.where(measurement_type: @measurement_type).order(:measurement_type, :measurement_name).pluck(:measurement_name, :id)
		@ingredient = Ingredient.new
		respond_to do |format|
			format.js
			format.html
		end
	end

	def create
		@recipe = Recipe.find(params[:recipe_id])
		@ingredient = Ingredient.new(ingredient_params)
		@groceries = Grocery.all.order(:grocery_name).pluck(:grocery_name, :id)
		@measurement_types = Measurement.measurement_types
		@measurement_type = @measurement_types.first
		@measurements = Measurement.where(measurement_type: @measurement_type).order(:measurement_type, :measurement_name).pluck(:measurement_name, :id)
		if @ingredient.save
			respond_to do |format|
				format.js do
					@ingredient = Ingredient.new
					render :new
				end
				format.html { redirect_to new_recipe_ingredient_path(@recipe) }
			end
		else
			respond_to do |format|
				format.js { render :new }
				format.html { render :new }
			end
		end
	end

	private
	def ingredient_params
		params.require(:ingredient).permit(:grocery_id, :measurement_id, :amount)
	end
end
