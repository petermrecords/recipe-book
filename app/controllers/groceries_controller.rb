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

	def selectbox
		@grocery_types = Grocery.grocery_types
		@grocery_type = params[:grocery_type]
		@groceries = Grocery.where(grocery_type: @grocery_type)
		respond_to do |format|
			format.js
		end
	end

	private
	def grocery_params
		params.require(:grocery).permit(:grocery_name,:description,:grocery_type)
	end
end