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
		@grocery_types = Grocery.grocery_types
		@grocery_type = params[:grocery_type]
		respond_to do |format|
			format.js
		end
	end

	def create
		@grocery = Grocery.new(grocery_params)
		@grocery_types = Grocery.grocery_types
		@grocery_type = params[:grocery][:grocery_type]
		if @grocery.save
			@grocery = Grocery.new
			respond_to do |format|
				format.js
			end
		else
			respond_to do |format|
				format.js
			end
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
		@groceries = Grocery.where(grocery_type: @grocery_type).order(:grocery_name).pluck(:grocery_name, :id)
		respond_to do |format|
			format.js
		end
	end

	private
	def grocery_params
		params.require(:grocery).permit(:grocery_name,:description,:grocery_type)
	end
end
