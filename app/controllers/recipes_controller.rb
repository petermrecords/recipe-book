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
		@recipe.admin = current_admin
		if @recipe.save
		else
			render :new
		end
	end

	def edit
	end

	def update
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
		elsif @recipe && !(@recipe.admin == current_admin || current_admin.is_super_admin?)
			flash[:alert] = 'You are not authorized to access this.'
			redirect_to :back
		end
	end
end
