class RecipesController < ApplicationController
	before_action only: [:new, :create] do
		authorize_admin
	end

	before_action only: [:edit, :update, :destroy] do
		authorize_recipe_owner(params[:id])
	end

	def index
	end

	def show
	end

	def new
		@recipe = Recipe.new
	end

	def create
		@recipe = Recipe.new(recipe_params)
		@recipe.author = current_admin
		if @recipe.save
			redirect_to edit_recipe_path(@recipe)
		else
			@errors = @recipe.errors.full_messages
			render :new
		end
	end

	def edit
		@recipe = Recipe.find(params[:id])
		respond_to do |format|
			format.js
			format.html
		end
	end

	def update
		@recipe = Recipe.find(params[:id])
		@recipe.update(recipe_params)
		if @recipe.save
			redirect_to edit_recipe_path(@recipe)
		else
			@errors = @recipe.errors.full_messages
			respond_to do |format|
				format.html { render :edit }
				format.js { render :edit }
			end
		end
	end

	def destroy
	end

	private
	def recipe_params
		params.require(:recipe).permit(:dish_name, :description, :serves)
	end
end
