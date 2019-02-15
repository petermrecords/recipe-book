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
			render :edit
		end
	end

	def destroy
	end

	private
	def recipe_params
		params.require(:recipe).permit(:dish_name, :description, :serves)
	end

	def authorize_recipe_owner(id)
		@recipe ||= Recipe.find(id)
		if @recipe && !current_admin
			flash[:notice] = 'You must be logged in to access this.'
			redirect_to login_path and return
		elsif @recipe && !(@recipe.author == current_admin || current_admin.is_super_admin?)
			flash[:alert] = 'You are not authorized to access this.'
			redirect_to :back
		end
	end
end
