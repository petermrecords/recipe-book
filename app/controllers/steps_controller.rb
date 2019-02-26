class StepsController < ApplicationController
	before_action do
		authorize_recipe_owner(params[:recipe_id])
	end

	def new
		@recipe = Recipe.find(params[:recipe_id])
		@step = Step.new
		respond_to do |format|
			format.js
		end
	end

	def create
		@recipe = Recipe.find(params[:recipe_id])
		@step = Step.new(step_params)
		@recipe.reindex_steps if @step.step_order != @recipe.next_step_index
		@step.prep_time = parse_prep_time(params[:step][:prep_time_value], params[:step],[:prep_time_units])
		if @step.save
			@step = Step.new
			respond_to do |format|
				format.js
			end
		else
		end
	end

	def edit
		@step = Step.find(params[:id])
	end

	def update
	end

	def destroy
	end

	private
	def step_params
		params.require(:step).permit(:recipe_id, :step_order, :prep_time_value, :prep_time_units, :is_active, :instruction)
	end

	def parse_prep_time(value, units)
		[value.to_s, units.downcase].join(' ')
	end
end
