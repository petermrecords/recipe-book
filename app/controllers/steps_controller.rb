class StepsController < ApplicationController
	before_action do
		authorize_recipe_owner(params[:recipe_id])
		@navbar = 'admin_navbar'
	end

	def new
		@recipe = Recipe.includes(:steps).find(params[:recipe_id])
		@step = Step.new
		respond_to do |format|
			format.js
			format.html
		end
	end

	def create
		@step = Step.new(step_params)
		@step.prep_time = parse_prep_time(params[:step][:prep_time_value], params[:step][:prep_time_units])
		@step.is_active = !!params[:step][:is_active]
		if @step.save
			@recipe = Recipe.includes(:steps).find(params[:recipe_id])
			@recipe.reindex_steps(nil)
			@step = Step.new
			respond_to do |format|
				format.js { render :new }
				format.html { redirect_to new_recipe_step_path(@recipe) }
			end
		else
			@alert = errors_alert("Your content could not be saved:\r\n\r\n",@step.errors.full_messages)
			respond_to do |format|
				format.js { render :'recipes/errors' }
				format.html { render :new }
			end
		end
	end

	def edit
		@recipe = Recipe.includes(:steps).find(params[:recipe_id])
		@step = Step.find(params[:id])
		respond_to do |format|
			format.js { render :new }
			format.html { render :new }
		end
	end

	def update
		@step = Step.find(params[:id])
		@step.update(step_params)
		@step.prep_time = parse_prep_time(params[:step][:prep_time_value], params[:step][:prep_time_units])
		@step.is_active = !!params[:step][:is_active]
		if @step.save
			@recipe = Recipe.includes(:steps).find(params[:recipe_id])
			@recipe.reindex_steps(nil)
			@step = Step.new
			respond_to do |format|
				format.js { render :new }
				format.html { redirect_to new_recipe_step_path(@recipe) }
			end
		else
			@alert = errors_alert("Your content could not be saved:\r\n\r\n",@step.errors.full_messages)
			respond_to do |format|
				format.js { render :'recipes/errors' }
				format.html { render :new }
			end
		end
	end

	def destroy
		@step = Step.find(params[:id])
		@step.destroy
		@recipe = Recipe.includes(:steps).find(params[:recipe_id])
		@recipe.reindex_steps(nil)
		respond_to do |format|
			format.js
			format.html { redirect_to new_recipe_step_path(@recipe) }
		end
	end

	private
	def step_params
		params.require(:step).permit(:recipe_id, :step_order, :instruction)
	end

	def parse_prep_time(value, units)
		[value.to_s, units.downcase].join(' ')
	end
end
