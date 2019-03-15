class IngredientsController < ApplicationController
	before_action do
		authorize_recipe_owner(params[:recipe_id])
		@navbar = 'admin_navbar'
	end

	def new
		@recipe = Recipe.includes(:ingredients).find(params[:recipe_id])
		@grocery_types = Grocery::GROCERY_TYPES
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
		debugger
		if @ingredient.save
			@recipe = Recipe.includes(:ingredients).find(params[:recipe_id])
			@grocery_types = Grocery::GROCERY_TYPES
			@grocery_type = @grocery_types.first
			@groceries = Grocery.where(grocery_type: @grocery_type).order(:grocery_name).pluck(:grocery_name, :id)
			@measurement_types = Measurement.measurement_types
			@measurement_type = @measurement_types.first
			@measurements = Measurement.where(measurement_type: @measurement_type).order(:measurement_type, :measurement_name).pluck(:measurement_name, :id)
			@ingredient = Ingredient.new
			respond_to do |format|
				format.js { render :new }
				format.html { redirect_to new_recipe_ingredient_path(@recipe) }
			end
		else
			@alert = errors_alert("Your content could not be saved:\r\n\r\n",@ingredient.errors.full_messages)
			respond_to do |format|
				format.js { render :'recipes/errors' }
				format.html { render :new }
			end
		end
	end

	def edit
		@ingredient = Ingredient.find(params[:id])
		@recipe = @ingredient.recipe
		@grocery_types = Grocery::GROCERY_TYPES
		@grocery_type = @ingredient.grocery.grocery_type
		@groceries = Grocery.where(grocery_type: @grocery_type).order(:grocery_name).pluck(:grocery_name, :id)
		@measurement_types = Measurement.measurement_types
		@measurement_type = @ingredient.measurement.measurement_type
		@measurements = Measurement.where(measurement_type: @measurement_type).order(:measurement_type, :measurement_name).pluck(:measurement_name, :id)
		respond_to do |format|
			format.js { render :new }
			format.html { render :new }
		end
	end

	def update
		@ingredient = Ingredient.find(params[:id])
		@recipe = @ingredient.recipe
		@grocery_types = Grocery::GROCERY_TYPES
		@measurement_types = Measurement.measurement_types
		@ingredient.update(ingredient_params)
		if @ingredient.save
			@grocery_type = @grocery_types.first
			@groceries = Grocery.where(grocery_type: @grocery_type).order(:grocery_name).pluck(:grocery_name, :id)
			@ingredient = Ingredient.new
			@measurement_type = @measurement_types.first
			@measurements = Measurement.where(measurement_type: @measurement_type).order(:measurement_type, :measurement_name).pluck(:measurement_name, :id)
			respond_to do |format|
				format.js { render :new }
				format.html { redirect_to new_recipe_ingredient_path(@recipe) }
			end
		else
			@alert = errors_alert("Your content could not be saved:\r\n\r\n",@ingredient.errors.full_messages)
			respond_to do |format|
				format.js { render :'recipes/errors' }
				format.html { render :new }
			end
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
