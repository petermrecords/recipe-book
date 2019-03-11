class RecipesController < ApplicationController
	before_action only: [:new, :create, :admin] do
		authorize_admin
	end

	before_action only: [:edit, :update, :destroy, :preview, :publish] do
		authorize_recipe_owner(params[:id])
	end

	def index
	end

	def show
		@recipe = Recipe.includes(:steps, :ingredients).find(params[:id])
	end

	def new
		@recipe = Recipe.new
		@recipe_roles = Recipe::RECIPE_ROLES
	end

	def create
		@recipe = Recipe.new(recipe_params)
		@recipe_roles = Recipe::RECIPE_ROLES
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
		@recipe_roles = Recipe::RECIPE_ROLES
		respond_to do |format|
			format.js
			format.html
		end
	end

	def update
		@recipe = Recipe.find(params[:id])
		@recipe_roles = Recipe::RECIPE_ROLES
		@recipe.update(recipe_params)
		if @recipe.save
			redirect_to edit_recipe_path(@recipe)
		else
			@alert = errors_alert("Your content could not be saved:\r\n\r\n",@recipe.errors.full_messages)
			respond_to do |format|
				format.html { render :edit }
				format.js { render :'recipes/errors' }
			end
		end
	end

	def destroy
		@recipe = Recipe.find(params[:id])
	end

	def preview
		@recipe = Recipe.includes(:steps, :ingredients).find(params[:id])
		render :show
	end

	def publish
		@recipe = Recipe.find(params[:id])
		@recipe.published_at = DateTime.now
		@recipe.save
	end

	def admin
		if params[:published]
			@recipes = Recipe.where(author: current_admin).order(updated_at: :desc)
		elsif params[:sitewide]
			@recipes = Recipe.order(updated_at: :desc)
		else
			@recipes = Recipe.unpublished.where(author: current_admin).order(updated_at: :desc)
		end
		respond_to do |format|
			format.js
			format.html
		end
	end

	private
	def recipe_params
		params.require(:recipe).permit(:dish_name, :dish_role, :description, :serves)
	end
end
