class StepsController < ApplicationController
	before_action do
		authorize_recipe_owner(params[:recipe_id])
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
		@recipe = Recipe.includes(:steps).find(params[:recipe_id])
		@step = Step.new(step_params)
		@step.prep_time = parse_prep_time(params[:step][:prep_time_value], params[:step][:prep_time_units])
		@step.is_active = !!@step.is_active
		@recipe.reindex_steps(@step.step_order) if @step.step_order != @recipe.next_step_index
		if @step.save
			@step = Step.new
			respond_to do |format|
				format.js { render :new } 
			end
		else
		end
	end

	def edit
		@recipe = Recipe.includes(:steps).find(params[:recipe_id])
		@step = Step.find(params[:id])
	end

	def update
		@recipe = Recipe.includes(:steps).find(params[:recipe_id])
		@step = Step.find(params[:id])
		@step.update(step_params)
		@step.prep_time = parse_prep_time(params[:step][:prep_time_value], params[:step][:prep_time_units])
		@step.is_active = !!@step.is_active
		@recipe.reindex_steps(@step.step_order)
		debugger
		if @step.save
			@step = Step.new
			respond_to do |format|
				format.js { render :new }
			end
		else
		end
	end

	def destroy
		@recipe = Recipe.includes(:steps).find(params[:recipe_id])
		@step = Step.find(params[:id])
		@recipe.reindex_steps(@step.step_order)
		@step.destroy
		respond_to do |format|
			format.js
			format.html { redirect_to new_recipe_step_path(@recipe) }
		end
	end

	private
	def step_params
		params.require(:step).permit(:recipe_id, :step_order, :is_active, :instruction)
	end

	def parse_prep_time(value, units)
		[value.to_s, units.downcase].join(' ')
	end
end
