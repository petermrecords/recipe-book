class GroceriesController < ApplicationController
	before_action only: [:new,:create,:edit,:update,:destroy] do
		authorize_admin
	end

	def index
	end

	def show
	end

	def new
		@grocery = Grocery.new
	end

	def create
		@grocery = Grocery.new(grocery_params)
		if @grocery.save
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
	def grocery_params
		params.require(:grocery).permit(:grocery_name,:description,:grocery_type)
	end
end
