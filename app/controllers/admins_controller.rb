class AdminsController < ApplicationController
	def new
		@admin = Admin.new
		@submit = 'submit_new'
	end

	def create
		@admin = Admin.new(admin_params)
		if @admin.save
		else
			@submit = 'submit_new'
			render :new
		end
	end

	def edit
		@admin = Admin.kept.find(params[:id])
		@submit = 'submit_edit'
	end

	def update
		@admin = Admin.kept.find(params[:id]).update(admin_params)
		if @admin.save
		else
			@submit = 'submit_edit'
			render :edit
		end
	end

	def destroy
		@admin = Admin.find(params[:id])
		@admin.discard
	end

	private
	def admin_params
		params.require(:admin).permit(:first_name, :last_name, :email, :password, :password_confirmation)
	end
end
