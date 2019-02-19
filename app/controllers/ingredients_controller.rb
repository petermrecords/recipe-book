class IngredientsController < ApplicationController
	before_action do
		authorize_recipe_owner(params[:recipe_id])
	end

	def new
		@recipe = Recipe.includes(:ingredients).find(params[:recipe_id])
		@grocery_types = Grocery.grocery_types
		@grocery_type = @grocery_types.first
		@groceries = Grocery.where(grocery_type: @grocery_type).order(:grocery_name).pluck(:grocery_name, :id)
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
		@ingredient = Ingredient.new(ingredient_params)
		if @ingredient.save
			@recipe = Recipe.includes(:ingredients).find(params[:recipe_id])
			@grocery_types = Grocery.grocery_types
			@grocery_type = @grocery_types.first
			@groceries = Grocery.where(grocery_type: @grocery_type).order(:grocery_name).pluck(:grocery_name, :id)
			@measurement_types = Measurement.measurement_types
			@measurement_type = @measurement_types.first
			@measurements = Measurement.where(measurement_type: @measurement_type).order(:measurement_type, :measurement_name).pluck(:measurement_name, :id)
			@ingredient = Ingredient.new
			respond_to do |format|
				format.js do
					render :new
				end
				format.html { redirect_to new_recipe_ingredient_path(@recipe) }
			end
		else
			@errors = @ingredient.errors
			byebug
			@grocery_types = Grocery.grocery_types
			@grocery_type = @ingredient.grocery ? @ingredient.grocery.grocery_type : @grocery_types.first
			@groceries = Grocery.where(grocery_type: @grocery_type).order(:grocery_name).pluck(:grocery_name, :id)
			@measurement_types = Measurement.measurement_types
			@measurement_type = @ingredient.measurement ? @ingredient.measurement.measurement_type : @measurement_types.first
			@measurements = Measurement.where(measurement_type: @measurement_type).order(:measurement_type, :measurement_name).pluck(:measurement_name, :id)
			respond_to do |format|
				format.js { render :new }
				format.html { render :new }
			end
		end
	end

	def edit
		@ingredient = Ingredient.find(params[:id])
		@recipe = @ingredient.recipe
		@grocery_types = Grocery.grocery_types
		@grocery_type = @ingredient.grocery.grocery_type
		@groceries = Grocery.where(grocery_type: @grocery_type).order(:grocery_name).pluck(:grocery_name, :id)
		@measurement_types = Measurement.measurement_types
		@measurement_type = @ingredient.measurement.measurement_type
		@measurements = Measurement.where(measurement_type: @measurement_type).order(:measurement_type, :measurement_name).pluck(:measurement_name, :id)
		respond_to do |format|
			format.js { render :new }
		end
	end

	def update
		@ingredient = Ingredient.find(params[:id])
		@recipe = @ingredient.recipe
		@grocery_types = Grocery.grocery_types
		@measurement_types = Measurement.measurement_types
		@ingredient.update(ingredient_params)
		if @ingredient.save
			@grocery_type = @grocery_types.first
			@groceries = Grocery.where(grocery_type: @grocery_type).order(:grocery_name).pluck(:grocery_name, :id)
			@ingredient = Ingredient.new
			@measurement_type = @measurement_types.first
			@measurements = Measurement.where(measurement_type: @measurement_type).order(:measurement_type, :measurement_name).pluck(:measurement_name, :id)
		else
			@errors = @ingredient.errors
			@grocery_type = @ingredient.grocery.grocery_type
			@groceries = Grocery.where(grocery_type: @grocery_type).order(:grocery_name).pluck(:grocery_name, :id)
			@measurement_type = @ingredient.measurement.measurement_type
			@measurements = Measurement.where(measurement_type: @measurement_type).order(:measurement_type, :measurement_name).pluck(:measurement_name, :id)
		end
		respond_to do |format|
			format.js { render :new }
		end
	end

	def destroy
		@ingredient = Ingredient.find(params[:id])
		@ingredient.destroy
		respond_to do |format|
			@recipe = Recipe.includes(:ingredients).find(params[:recipe_id])
			format.js
			format.html { redirect_to new_recipe_ingredient_path(@recipe) }
		end
	end

	private
	def ingredient_params
		params.require(:ingredient).permit(:recipe_id, :grocery_id, :measurement_id, :amount, :measurement_override, :comment)
	end
end
