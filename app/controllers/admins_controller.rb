class AdminsController < ApplicationController
	def new
		@admin = Admin.new
	end

	def create
		@admin = Admin.new(admin_params)
		if @admin.save
			redirect_to root_path
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
	def admin_params
		params.require(:admin).permit(:first_name, :last_name, :email, :password, :password_confirmation)
	end
end
